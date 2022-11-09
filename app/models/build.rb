# building related logic
class Build
  extend ActiveModel::Naming
  def initialize(acting_user, game, hex)
    @actor = acting_user
    @game = game
    @hex = hex
    @errors = ActiveModel::Errors.new(self)
  end

  attr_accessor :game, :hex, :actor
  attr_reader :errors

  def valid?
    started?
  end

  def started?
    @game.errors.add(:base, "The Game has not started!") unless @game.started? 
    @game.started?
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
