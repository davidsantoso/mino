require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase

  setup do
    @request.headers["Accept"] = "application/json"
    @request.headers["Content-Type"] = "application/json"
  end

  test "should create a new authentication" do
    assert_difference('Authentication.count') do
      # This needs to be updated with the correct encrypted request body
      post :create, user: { email: "beth.greene@mail.com" }
    end

    authentication = assigns(:authentication)

    assert_empty authentication.errors
    assert_not_nil authentication.challenge
    assert_response :success
  end

  test "should not create authentication if user is not verified" do
    # This needs to be updated with the correct encrypted request body
    post :create, user: { email: "rick.grimes@mail.com" }
    assert_response :conflict
  end
end
