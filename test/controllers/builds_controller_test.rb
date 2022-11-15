require "test_helper"

class BuildsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @game = games(:one)
    @user = users(:one)
    sign_in @user
    @game.start!
    @game.state['players']["0"]['shares'] = ['red']
    @game.state['companies']['red']['money'] = 20
    @game.save
  end
  test "should get new" do
    get new_build_url(@game)
    assert_response :success
  end

  test "valid build" do
    post game_builds_url(@game), params: { hex: ['R4','R3','R2'], company: 'red' }
    assert_response :redirect
    @game.reload
    assert @game.state['companies']['red']['money'] < 20, "company money should diminish in building"
    assert @game.state['companies']['red']['track'] == 19 - 3, "company track should diminish in building"
    assert @game.state['hexes']['R4']['built'] == ['red'], "the hexes should be built now by red"
  end

  test "insufficient money to build" do
    # with zero money the rendering of the view fails :DDD TODO
    @game.state['companies']['red']['money'] = 1
    @game.save
    post game_builds_url(@game), params: { hex: ['E0'], company: 'red' }
    assert_response :unprocessable_entity
  end

  test "buildingin too many hexes" do
    post game_builds_url(@game), params: { hex: %w[E0 E1 E2 E3], company: 'red' }
    assert_response :unprocessable_entity
  end

  test "enough tracks to build" do
    @game.state['companies']['red']['track'] = 1
    @game.save
    post game_builds_url(@game), params: { hex: ['E0', 'E2'], company: 'red' }
    assert_response :unprocessable_entity
  end

  test "player owns shares" do
    @game.state['players']['0']['shares'] = []
    @game.save
    post game_builds_url(@game), params: { hex: ['E0'], company: 'red' }

    assert_response :unprocessable_entity
  end

  test "connects to company track" do
    assert false
  end
end
