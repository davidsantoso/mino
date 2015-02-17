require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase

  test "verification should return 403 without params" do
    get :verification
    assert_response :forbidden
  end

  test "verification should return 403 without email param" do
    get :verification, {token: "nfAen2193nS"}
    assert_response :forbidden
  end

  test "verification should return 403 without token param" do
    get :verification, {email: "sasha@mail.com"}
    assert_response :forbidden
  end

  test "verification should return 403 if token does not match" do
    get :verification, {email: "sasha@mail.com", token: "the_incorrect_token"}
    assert_response :forbidden
  end

  test "verification should set user to verified true if token does match" do
    # setup sets headers to application/json by default since it's normally
    # just responding to API requests so we need to override for this test
    @request.headers["Accept"] = "text/html"
    @request.headers["Content-Type"] = "text/html"

    get :verification, {email: "sasha@mail.com", token: "TH0s7wfHfzqFWTMB21pRgy9aTrMlDecFv"}

    @user = users(:two)

    assert_response :ok
    assert_equal true, @user.verified
    assert_template :verification
  end

  test "verification should render verification view if token does match" do
    # setup sets headers to application/json by default since it's normally
    # just responding to API requests so we need to override for this test
    @request.headers["Accept"] = "text/html"
    @request.headers["Content-Type"] = "text/html"

    get :verification, {email: "sasha@mail.com", token: "TH0s7wfHfzqFWTMB21pRgy9aTrMlDecFv"}

    assert_response :ok
    assert_template :verification
  end
end
