require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do

  end

  test "should set handle for new registrations" do
    get new_user_registration_path
    assert_response :success

    post "/users", params: {user: {email: "atte2@example.com", password: "changeMe2.", password_confirmation: "changeMe2.", handle: "äiäpelaaja"}}
    follow_redirect!
    assert_response :success
    assert User.find_by_email("atte2@example.com")
    assert User.find_by_handle("äiäpelaaja") 
  end
end
