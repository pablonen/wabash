require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @game = games(:one)
  end

  test 'in_game?' do
    assert @user.in_game?(@game)
    @user.game_players.destroy_all
    assert !@user.in_game?(@game)
  end
end
