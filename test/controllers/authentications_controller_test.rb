require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase

  setup do
    @request.headers["Accept"] = "application/json"
    @request.headers["Content-Type"] = "application/json"
  end

  test "should create a new authentication" do
    assert_difference('Authentication.count') do
      post :create, user: {email: "beth.greene@mail.com"}
    end

    authentication = assigns(:authentication)

    assert_empty authentication.errors
    assert_response :success
  end
end
