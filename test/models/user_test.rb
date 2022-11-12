require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @user2 = users(:two)
    @game = games(:one)
  end

  test 'in_game?' do
    assert @user.in_game?(@game)
    @user.game_players.destroy_all
    assert !@user.in_game?(@game)
  end

  test 'seat_in' do
    @user.join_in(@game)
    assert @user.seat_in(@game), 0
    @user2.join_in(@game)
    assert @user2.seat_in(@game), 1
  end
end
