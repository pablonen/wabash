require "test_helper"

class DevelopmentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @game = games(:one)
    @user = users(:one)
    sign_in(@user)
    @game.start!
    @game.state['hexes'][Game::PITTSBURGH]['built']= ['red']
    @game.save
  end

  test "should get new" do
    get new_development_url(@game)
    assert_response :success
  end
end
