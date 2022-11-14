# auction logic
# TODO, rename to AuctionAction
class Auction
  extend ActiveModel::Naming
  def initialize(acting_user, game, company, bid, starting_bid: false, pass: false)
    @actor = acting_user
    @game = game
    @company = company
    @bid = bid
    @phase = @game.phase
    @errors = ActiveModel::Errors.new(self)
    @pass = pass
    @starting_bid = starting_bid
  end

  attr_accessor :actor, :game, :company, :bid, :phase, :pass, :starting_bid
  attr_reader :errors

  def valid?
    on_bidding_phase? &&
    on_turn? &&
    valid_bid? &&
    sufficient_money?
  end

  def valid_pass?
    on_bidding_phase? &&
    on_turn?
  end

  def valid_start?
    on_start_auction_phase? &&
    on_turn? &&
    sufficient_money? &&
    shares_left?
  end

  # cannot start an auction on build/dev/bidding phase
  # cannot bid on build/dev phase
  def on_start_auction_phase?
    @game.errors.add(:base, "Cannot auction/bid on build phase") unless @game.can_auction?
    @game.can_auction?
  end

  def on_bidding_phase?
    @game.errors.add(:base, "Nothing to bid, or build/dev phase") unless @game.phase?(:bidding)
    @game.phase?(:bidding)
  end

  def on_turn?
    @game.errors.add(:base, "Not your turn to bid") unless @game.user_acting?(@actor)
    @game.user_acting?(@actor)
  end

  def sufficient_money?
    @game.errors.add(:base, "Not enough money for bid") if @game.player_money(@actor) < @bid
    @game.player_money(@actor) > @bid
  end

  # TODO, implement minimum bid rules
  def valid_bid?
    @game.errors.add(:base, "Bid must be higher than going price") if @bid < @game.state['high_bid'].to_i
    @bid > @game.state['high_bid']
  end

  def shares_left?
    shares_left = @game.state['companies'][@company]['shares'].nonzero?
    unless shares_left
      @game.errors.add(:base, "Company #{@company} has no shares to auction")
    end
    shares_left
  end
  # Implementation boilerplate see https://api.rubyonrails.org/v7.0.4/classes/ActiveModel/Errors.html 
  def read_attribute_for_validation(attr)
    send(attr)
  end

  def self.human_attribute_name(attr, options = {})
    attr
  end

  def self.lookup_ancestors
    [self]
  end

end
