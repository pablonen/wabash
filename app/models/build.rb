# building related logic
class Build
  # making this AR backed model, would give us errorhandling for the views and facilitate flashing notices etc.
  # having to shove the hex param into the game params smells like we would need a new builds controller, maybe next TODO
  def initialize(acting_user, game, hex)
    @actor = acting_user
    @game = game
    @hex = hex
  end

  def validate
    @game.user_acting?(@actor)
  end
end
