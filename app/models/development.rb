# development validation
class Development
  extend ActiveModel::Naming
  def initialize(acting_user, game, hex)
    @actor = acting_user
    @game = game
    @hex = hex
  end

  attr_accessor :game, :hex, :actor, :company, :cost
  attr_reader :errors

  def valid?
    not_ended? &&
    on_turn? &&
    development_available? &&
    started? &&
    valid_development? &&
    track_built?
  end

  def not_ended?
    @game.errors.add(:base, "The game has ended!") if @game.ended_at
    !@game.ended_at
  end

  def started?
    @game.errors.add(:base, "The Game has not started!") unless @game.started?
    @game.started?
  end

  def on_turn?
    @game.errors.add(:base, "It is not your turn to build!") unless @game.user_acting?(@actor)
    @game.user_acting?(@actor)
  end

  def development_available?
    @game.errors.add(:base, "No development actions available") unless @game.development_available?
    @game.development_available?
  end

  def valid_development?
    @game.errors.add(:base, "Hex #{@hex} is not developpable") unless @game.hex_developpable?(@hex)
    @game.hex_developpable? @hex
  end

  def track_built?
    @game.errors.add(:base, "Hex #{@hex} needs to have company track built to be developpable") unless @game.built? @hex
    @game.built? @hex
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
