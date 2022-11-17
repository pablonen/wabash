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

  def built?(hex)
    return false unless state.dig("hexes", hex, "built")
    state.dig("hexes", hex, "built")
  end

  def owner
    user
  end

  def build(build)
    # remove company money for cost
    state['companies'][build.company]['money'] -= build.cost
    # build the hexes
    build.hexes.each do |hex|
      state['hexes'][hex]['built'] << build.company
      state['companies'][build.company]['built_track'] << hex
    end
    # remove tracks from company
    state['companies'][build.company]['track'] -= build.hexes.size
    # TODO, increase the hex cost here? or in build_cost_for ?
    # next turn
    next_turn!
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
    state["phase"] = :choose_action
    state["acting_seat"] = (state["acting_seat"] + 1) % number_of_players
    save
  end

  def started?
    started
  end

  def start!
    state[:phase] = :choose_action
    state[:acting_seat] = 0
    starting_money = 120 / players.size

    state[:players] = {}
    game_players.pluck(:seat).each do |seat|
      state[:players][seat] = {money: starting_money, shares: [] }
    end

    # updates other dirty attributes on the object, in this case money of
    # the players in state
    update_attribute(:started, DateTime.now)
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
    state['companies'][auction.company]['shares'] -= 1
    # add money to the company
    state['companies'][state['auction']]['money'] += state['high_bid'].to_i

    # change phase to action choosing
    state["phase"] = :choose_action
    save
    # advance acting player by one
    next_turn!
  end

  def number_of_players
    players.size
  end

  # TODO, rename to available_companies_for_auction
  def available_companies
    state["companies"].reduce([]) do |available, (color, data)|
      if !data["shares"].zero? && data["started"]
        available << color
      end
      available
    end
  end

  def available_companies_for_building(user)
    # TODO, shouldnt return nils ?
    user.shares(self).uniq.reduce([]) do |available, company|
      if state["companies"][company]['track'].nonzero? && state["companies"][company]['money'].positive?
        available << company
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

        column_first = j.zero?
        row_first = i.zero?
        draw = true if state['hexes'][coordinate(i,j)]

        yield Hex.new(x,y,i,j,hex_id,hex_type,hex_build_cost, hex_built, column_first, row_first, draw, hex_income)
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
