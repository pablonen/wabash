# TODO, started column should be renamed to started_at
class Game < ApplicationRecord
  has_many :game_players, dependent: :destroy
  has_many :players, through: :game_players, source: :user
  belongs_to :user
  HEX_H = 18
  HEX_W = 15
  MAP_COLS = 19
  MAP_ROWS = 11

  HEX_DATA = {}
  COL_ALPHA = ('A'..'S').to_a

  DETROIT = 'E0'
  WHEELING = 'I6'
  PITTSBURGH = 'K4'
  CHICAGO = 'A2'
  FORT_WAYNE = 'D3'

  def broadcast_updates
    self.players.each do |player|
      broadcast_replace_to [User,player,self], partial: "games/game", locals: { user: player }
    end
  end

  def built?(hex)
    return false if state.dig("hexes", hex, "built").try(:empty?)
    state.dig("hexes", hex, "built")
  end

  def owner
    user
  end

  def pass_action(action)
    state[ActiveSupport::Inflector.pluralize(action.action)] += 1
    next_turn!
  end

  def build(build)
    state['builds'] += 1
    # remove company money for cost
    state['companies'][build.company]['money'] -= build.cost
    # build the hexes
    build.hexes.each do |hex|
      state['hexes'][hex]['built'] << build.company
      state['companies'][build.company]['built_track'] << hex
      state['companies'][build.company]['income'] += state['hexes'][hex]['income'].to_i
    end
    # remove tracks from company
    state['companies'][build.company]['track'] -= build.hexes.size
    # TODO, increase the hex cost here? or in build_cost_for?

    # If chicago was built for the first time, trigger the chicago dividend
    # and start the black company
    if build.hexes.include?(CHICAGO)
      if !state['companies'][build.company]['chicago_dividends_paid']
        chicago_dividend!(build.company)
        state['companies'][build.company]['chicago_dividends_paid'] = true
      end

      if !state['companies']['black']['started']
        start_wabash! build.actor
        return
      end
    end

    # next turn
    if lokomotive_end?
      end_game!
    else
      next_turn!
    end
  end

  def develop(development)
    state['developments'] += 1

    if development.hex == WHEELING
      state['hexes'][development.hex]['income'] += 1
      state['hexes'][development.hex]['built'].each do |company|
        state['companies'][company]['income'] += 1

      end
    elsif development.hex == PITTSBURGH
      state['hexes'][development.hex]['income'] += 2
      state['hexes'][development.hex]['built'].each do |company|
        state['companies'][company]['income'] += 2
      end
    else
      state['hexes'][development.hex]['developped'] = true
      state['hexes'][development.hex]['income'] += state['hexes'][development.hex]['development'].to_i
      state['hexes'][development.hex]['built'].each do |company|
        state['companies'][company]['income'] += state['hexes'][development.hex]['development'].to_i
      end
    end

    if development_end?
      end_game!
    else
      next_turn!
    end
  end

  def hex_developpable?(hex)
    return false if state['hexes'][hex]['type'] == 'field'
    return false if state['hexes'][hex]['type'] == 'forest'
    return false if state['hexes'][hex]['development'] == '0'
    return false if state['hexes'][hex]['developped']
    return false if hex == DETROIT
    return false if hex == WHEELING && state['hexes'][WHEELING]['income'] == 6
    return false if hex == PITTSBURGH && state['hexes'][PITTSBURGH]['income'] == 8
    true
  end

  # params need to be in axial since the method is recursive
  def builds_adjacent_to_track?(hexes_to_be_built, company_built_hexes)
   return true if hexes_to_be_built.empty?

    built_tracks_neighbours = company_built_hexes.flat_map do |hex|
      HexPathfinding.neighbours(hex)
    end

    confirmed_builds, yet_to_be_confirmed = hexes_to_be_built.partition do |to_be_built|
      built_tracks_neighbours.include? to_be_built
    end

    return false if confirmed_builds.empty?
    return builds_adjacent_to_track?( yet_to_be_confirmed, company_built_hexes + confirmed_builds )
  end

  def company_built_tracks(company)
    state['companies'][company]['built_track']
  end

  def build_cost_for(hexes)
    state['hexes'].slice(*hexes).map do |_, data|
      data['cost'].to_i
    end.sum
  end

  # saves all dirty attributes on object
  def next_turn!
    if round_end?
      dividend_phase!
    end
    state["phase"] = :choose_action
    state["acting_seat"] = (state["acting_seat"] + 1) % number_of_players
    save
  end

  def round_end?
    build_used = state['builds'] >= 5
    developments_used = state['developments'] >= 4
    auctions_used = state['auctions'] >= 3

    [build_used, developments_used, auctions_used].count(true) == 2
  end

  def started?
    started
  end

  def start!
    state[:phase] = :bidding
    state[:acting_seat] = 0
    state[:builds] = 0
    state[:auctions] = 0
    state[:developments] = 0
    starting_money = 120 / players.size

    state[:players] = {}
    game_players.pluck(:seat).each do |seat|
      state[:players][seat] = {money: starting_money, shares: [] }
    end

    # updates other dirty attributes on the object, in this case money of
    # the players in state
    update_attribute(:started, DateTime.now)
    initial_auction!('red', 0)
    save
  end

  def skip_initial_auction!
    state['phase'] = :choose_action
    state['initial_auction_done'] = true
    save
  end

  def initial_auction!(company, active_seat)
    state['phase'] = 'bidding'
    state['auction'] = company
    state['high_bid'] = 0
    state['high_bidder'] = 0
    state['bidding_seat'] = active_seat
    state['passers'] = []
    save
  end

  def phase
    state['phase']
  end

  def phase?(phase)
    state["phase"] == phase.to_s
  end

  def can_auction?
    state['phase'] == 'choose_action' || state['phase'] == 'bidding'
  end

  def start_auction!(auction)
    state['auctions'] += 1
    state[:phase] = :bidding
    state[:auction] = auction.company
    state[:high_bid] = auction.bid
    state[:high_bidder] = auction.actor.seat_in(auction.game)
    state[:bidding_seat] = (state[:high_bidder] + 1) % number_of_players
    state[:passers] = []
    save
  end

  # advances bidding_seat to the next bidder, need to check for auction end before calling
  # TODO, refactor the argument away
  def next_bidder!(current_actor)
    state['bidding_seat'] = (state['bidding_seat'] +1 ) % number_of_players
    save
    next_bidder!(current_actor) if state['passers'].include?(acting_seat)
  end

  def player_on_seat(seat)
    game_players.find_by_seat(seat).user
  end

  def high_bid
    state['high_bid']
  end

  def high_bidder
    state['high_bidder']
  end

  def pass_auction!(passer, auction)
    state['passers'] << passer.seat_in(self)
    save

    # check auction end
    if auction_over? auction
      auction_over! auction
    else
      next_bidder! passer
    end
  end

  # TODO, maybe refactor the auction to not hold the acting user to make the
  # interface smaller
  def bid_auction!(bidder, auction)
    # record higher bid
    state['high_bid'] = auction.bid
    state['high_bidder'] = auction.actor.seat_in(auction.game)
    # next bidder
    next_bidder! bidder
  end

  def auction_over?(auction)
    state['passers'].size + 1 == number_of_players
  end

  def auction_over!(auction)
    # reduce winner money
    high_bidder_seat = state['high_bidder'].to_s
    state['players'][high_bidder_seat]['money'] = state['players'][high_bidder_seat]['money'] - state['high_bid'].to_i
    # add share to player
    state['players'][high_bidder_seat]['shares'] << auction.company
    # reduce company share count
    state['companies'][auction.company]['shares_sold'] += 1
    # add money to the company
    state['companies'][state['auction']]['money'] += state['high_bid'].to_i

    save
    if share_end?
      end_game!
    elsif !state['initial_auction_done']
      if auction.company == 'red'
        state['first_player_seat'] = state['high_bidder']
        next_company = 'blue'
      elsif auction.company == 'blue'
        next_company = 'yellow'
      elsif auction.company == 'yellow'
        next_company = 'green'
      else
        next_company = nil
        state['initial_auction_done'] = true
        state['phase'] = :choose_action
        # start with the red owner
        state['acting_seat'] = state['first_player_seat']
        save
        return
      end
      winner_seat = state['high_bidder']
      initial_auction! next_company, winner_seat
    else
      # advance acting player by one
      state["phase"] = :choose_action
      next_turn!
    end
  end

  def number_of_players
    players.size
  end

  def available_companies_for_auction
    state["companies"].reduce([]) do |available, (color, data)|
      if (data['shares'] - data.fetch('sold_shares', 0)).nonzero? && data["started"]
        available << color
      end
      available
    end
  end

  def company_income_per_share(company)
    no_sold_shares = state['companies'][company]['shares_sold']
    company_income = state['companies'][company]['income']
    return company_income if no_sold_shares.zero?
    (company_income / no_sold_shares.to_f).ceil
  end

  def dividend_phase!
    # general dividends
    state['players'].each do |seat, player_data|
      player_data['money'] += player_data['shares'].map { |company_share| company_income_per_share(company_share) }.sum
    end
    # reset dials
    state["builds"] = 0
    state["auctions"] = 0
    state["developments"] = 0
    # developing detroit
    state['hexes'][DETROIT]['income'] = state['hexes'][DETROIT]['income'].to_i + 1
    if ending?
      update_attribute(:ended_at, DateTime.now)
      finish_game!
    end

    if state['hexes'][DETROIT]['income'].to_i == 8
      end_game!
    end
  end

  def chicago_dividend!(company)
    per_company_share = company_income_per_share(company)
    state['players'].each do |seat, player|
      no_company_shares = player['shares'].count { |share| share == company }
      player['money'] += per_company_share * no_company_shares
    end
  end

  def start_wabash!( wabash_builder )
    state['companies']['black']['started'] = true
    state['hexes'][FORT_WAYNE]['built'] << 'black'
    state['companies']['black']['income'] = state['hexes'][FORT_WAYNE]['income']
    state['companies']['black']['built_track'] << FORT_WAYNE

    # start the auction
    builder_seat = wabash_builder.seat_in(self)
    initial_auction!('black', builder_seat)
  end

  def lokomotive_end?
    state['companies'].map do |_, company_data|
      company_data['track']
    end.select(&:zero?).count(true) >= 3
  end

  def development_end?
    # 3 or fever developments available
    false
  end

  def share_end?
    state['companies'].map do |_, company_data|
      company_data['shares'] - company_data['shares_sold']
    end.select(&:zero?).count(true) >= 3
  end

  def ending?
    state.fetch('ending', false)
  end

  def end_game!
    state[:ending] = true
  end

  def auction_available?
    state['auctions'] < 3
  end

  def development_available?
    state['developments'] < 4
  end

  def build_available?
    state['builds'] < 5
  end

  def action_available?(action)
    availability_method = action + '_available?'
    send(availability_method.to_sym)
  end

  def action_availability
    path_helper = Rails.application.routes.url_helpers
    { auction: { max: 3, used: state['auctions'], actions_left: 3 - state['auctions'], available: auction_available? ? "available" : "unavailable", link: path_helper.new_auction_path(self) },
      develop: { max: 4, used: state['developments'], actions_left: 4 - state['developments'], available: development_available? ? "available" : "unavailable", link: path_helper.new_development_path(self) },
      build: { max: 5, used: state['builds'], actions_left: 5 - state['builds'], available: build_available? ? "available" : "unavailable", link: path_helper.new_build_path(self) }}
  end

  def available_companies_for_building(user)
    available_companies = user.shares(self).uniq.reduce([]) do |available, company|
      if state["companies"][company]['track'].nonzero? && state["companies"][company]['money'].positive?
        available << company
      else
        available
      end
    end
  end

  def user_acting?(user)
    return false if game_players.empty?
    return false unless players.include? user
    if phase?(:bidding)
      seat_acting = bidding_seat
    else
      seat_acting = acting_seat
    end
    user_seat = user.seat_in(self)
    user_seat == seat_acting
  end

  def player_money(user)
    player_seat = user.seat_in(self).to_s
    state['players'][player_seat]['money']
  end

  def player_shares(user)
    player_seat = user.seat_in(self).to_s
    state['players'][player_seat]['shares']
  end

  def build_cost(hex)
    state["hexes"].dig(hex, "cost") || 0
  end

  def acting_seat
    if phase?(:bidding)
      seat = "bidding_seat"
    else
      seat = "acting_seat"
    end
    state[seat]
  end

  def acting_player
    game_players.find_by(seat: acting_seat).user
  end

  def bidding_seat
    return state["bidding_seat"]
  end

  def high_bidder_name
    player_on_seat(state['high_bidder']).handle
  end

  def companies
    state['companies']
  end

  def coordinate(i,j)
    COL_ALPHA[i]+j.to_s
  end

  def hex_type(hex)
    state["hexes"].dig(hex, "type") || "undefined" 
  end

  def hex_income(hex)
    state["hexes"].dig(hex,"income") || "as"
  end

  def hex_development(hex)
    state['hexes'].dig(hex, 'development')
  end

  def hex_developped(hex)
    state['hexes'].dig(hex, 'developped')
  end

  def players_enumerator
    state['players'].each do |seat, player_data|
      player = player_on_seat(seat.to_i)
      active = user_acting? player
      yield ({ name: player.handle, money: player_data['money'], shares: player_data['shares'].tally, acting: active })
    end
  end

  def grid_enumerator
    (HEX_W..HEX_W*MAP_COLS).step(HEX_W).each_with_index do |x, i|
      (HEX_H..HEX_H*MAP_ROWS).step(HEX_H).each_with_index do |y, j|
        if i % 2 == 1
          y = y + HEX_H / 2
        end
        hex_id = coordinate(i,j)
        hex_built = built?(hex_id)
        hex_build_cost = build_cost(hex_id)
        hex_type = hex_type(hex_id)
        hex_income = hex_income(hex_id)
        hex_development = hex_development(hex_id)
        hex_developped = hex_developped(hex_id)

        column_first = j.zero?
        row_first = i.zero?
        draw = true if state['hexes'][coordinate(i,j)]

        yield Hex.new(x,y,i,j,hex_id,hex_type,hex_build_cost, hex_built, column_first, row_first, draw, hex_income, hex_development, hex_developped )
      end
    end
  end

  def coord_enumerator
    COL_ALPHA.each do |col|
      GameMap::TYPE_BY_COLUMN[col].each_with_index do |type, i|
        yield col+i.to_s, type
      end
    end
  end
end
