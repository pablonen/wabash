require 'test_helper'

class GameBuildTest < ActiveSupport::TestCase
  setup do
    @game = games(:two)
    @user1 = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
    @game.start!
  end
end
