# building related logic
class Build
  def initialize(acting_user, game, hex)
    @actor = acting_user
    @game = game
    @hex = hex
  end

  def validate
    @game.user_acting?(@actor)
  end
end
