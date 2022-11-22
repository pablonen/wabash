# action passes
class PassAction
  extend ActiveModel::Naming

  def initialize(game, acting_user, action)
    @game = game
    @actor = acting_user
    @action = ActiveSupport::Inflector.singularize(action)
  end

  VALID_ACTIONS = %w[build development auction]

  attr_accessor :game, :actor, :action
  attr_reader :errors

  def valid?
    pp(not_ended?) &&
    pp(on_turn?) &&
    pp(started?) &&
    pp(valid_action?) &&
    pp(pass_action_available?)
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

  def valid_action?
    @game.errors.add(:base, "That is not a valid action?") unless VALID_ACTIONS.include? @action
    VALID_ACTIONS.include? @action
  end

  def pass_action_available?
    @game.errors.add(:base, "Actions of this kind already exhausted") unless @game.action_available? @action
    @game.action_available? @action
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
