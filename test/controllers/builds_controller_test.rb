require "test_helper"

class BuildsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @game = games(:one)
    @user = users(:one)
    @gp = game_players(:one)
    sign_in @user
  end
  test "should get new" do
    get new_build_url(@game)
    assert_response :success
  end
end
