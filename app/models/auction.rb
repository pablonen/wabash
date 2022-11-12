# auction logic
# TODO, rename to AuctionAction
class Auction
  extend ActiveModel::Naming
  def initialize(acting_user, game, company, bid)
    @actor = acting_user
    @game = game
    @company = company
    @bid = bid
    @phase = @game.phase
    @errors = ActiveModel::Errors.new(self)
  end

  attr_accessor :actor, :game, :company, :bid, :phase
  attr_reader :errors

  def valid?
    on_phase? &&
    sufficient_money?
  end

  # cannot start an auction on build/dev/bidding phase
  # cannot bid on build/dev phase
  def on_phase?
    @game.errors.add(:base, "Cannot auction on build phase") unless @game.can_auction?
    @game.can_auction?
  end

  def sufficient_money?
    true 
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
