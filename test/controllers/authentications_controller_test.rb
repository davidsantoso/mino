require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase

  setup do
    @request.headers["Accept"] = "application/json"
    @request.headers["Content-Type"] = "application/json"
  end

  test "should create a new authentication" do
    skip "Authentications API still a bit fuzzy"
    assert_difference('Authentication.count') do
      post :create, user: { email: "beth.greene@mail.com" }
    end

    authentication = assigns(:authentication)

    assert_empty authentication.errors
    assert_not_nil authentication.challenge
    assert_response :success
  end

  test "should not create authentication if user is not verified" do
    skip "Implement encyption and decryption of payloads"
    post :create, user: { email: "rick.grimes@mail.com" }
    assert_response :conflict
  end

  test "should return 403 if challenge is not decrypted" do
    skip "Implement challenge decryption check"
    patch :update, authentication: { challenge: "the_incorrect_challenge" }
    assert_response :forbidden
  end

  test "should activate authentication" do
    skip "Implement authenticaton activation"
    patch :update, authentication: { challenge: "52c23fb73c39eaabc6592a6279e61e1a901df93c13d418dadcd3e135e5555675" }

    authentication = assigns(:authentication)

    assert session[:token], authentication.token
    assert_response :ok
  end
end
