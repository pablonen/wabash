require "test_helper"

class AuctionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @game = games(:one)
    @user1 = users(:one)
    @user2 = users(:two)
    sign_in @user1
    @game.start!
    @game.skip_initial_auction!
  end

  test "should start auction" do
    get new_auction_url(@game)
    assert_response :success
  end

  test "should start auction on game" do
    post start_auction_url(@game), params: { company: "red", bid: 3}
    assert_redirected_to game_url(@game)
    @game.reload
    assert @game.user_acting?(@user2)
  end
end
