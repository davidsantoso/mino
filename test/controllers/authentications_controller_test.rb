require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase

  setup do
    @request.headers["Accept"] = "application/json"
    @request.headers["Content-Type"] = "application/json"
  end

  test "should create a new authentication" do
    assert_difference('Authentication.count') do
      post :create, user: { email: "beth.greene@mail.com" }
    end

    authentication = assigns(:authentication)

    assert_empty authentication.errors
    assert_not_nil authentication.challenge
    assert_response :success
  end

  # POST /authentications currently returns the following hash
  # if an account has not been verified yet:
  #
  # {
  #   "errors": {
  #     "user_id": [
  #       "email address has not been verified"
  #     ]
  #   }
  # }
  #
  # Error message makes sense, but the structure of the response
  # could probably use some thought. Makes sense to use the "user_id"
  # field since it's a field of the Authentication but...
  #
  # ¯\_(ツ)_/¯
  #
  test "should not create authentication if user is not verified" do
    post :create, user: { email: "rick.grimes@mail.com" }
    assert_response :conflict
  end

  test "should return 403 if challenge is not decrypted" do
    skip
    patch :update, authentication: { challenge: "the_incorrect_challenge" }
    assert_response :forbidden
  end

  test "should activate authentication" do
    skip
    patch :update, authentication: { challenge: "52c23fb73c39eaabc6592a6279e61e1a901df93c13d418dadcd3e135e5555675" }

    authentication = assigns(:authentication)

    assert session[:token], authentication.token
    assert_response :ok
  end
end
