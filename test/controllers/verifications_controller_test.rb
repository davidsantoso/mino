require 'test_helper'

class VerificationsControllerTest < ActionController::TestCase
  test "verification should return 403 without params" do
    get :index
    assert_response :forbidden
  end

  test "verification should return 403 if token does not exist" do
    get :index, { email: "sasha@mail.com", token: "the_incorrect_token"}
    assert_response :forbidden
  end

  test "verification should return 403 if token exists but email does not match" do
    get :index, { "email" => "the_wrong_email@mail.com", "token" => "DzHrKwgsbw8rIFLtJm25loEE-rY-4yPwxU0IkYbkcF4BIz1BGk50kW0afOx0g6sD0_HRLPJJqARlN4Tj-zU5Iw==" }
    assert_response :forbidden
  end

  test "verification should set user to verified true if token and email match" do
    get :index, { "email" => "rick.grimes@mail.com", "token" => "DzHrKwgsbw8rIFLtJm25loEE-rY-4yPwxU0IkYbkcF4BIz1BGk50kW0afOx0g6sD0_HRLPJJqARlN4Tj-zU5Iw==" }

    @user = users(:one)

    assert_response :ok
    assert_equal true, @user.verified
  end

  test "verification should render verification view if token does match" do
    # setup sets headers to application/json by default since it's normally
    # just responding to API requests so we need to override for this test
    @request.headers["Accept"] = "text/html"
    @request.headers["Content-Type"] = "text/html"

    get :index, { "email" => "rick.grimes@mail.com", "token" => "DzHrKwgsbw8rIFLtJm25loEE-rY-4yPwxU0IkYbkcF4BIz1BGk50kW0afOx0g6sD0_HRLPJJqARlN4Tj-zU5Iw==" }

    assert_response :ok
    assert_template :index
  end

  test "verification should return 403 if token exists but client signature does not match" do
    get :index, { "signature" => "the_wrong_signature", "token" => "" }
    assert_response :forbidden
  end

  test "verification should set user to verified true if token and email match" do
    get :index, { "signature" => "", "token" => "" }

    @user = users(:one)

    assert_response :ok
    assert_equal true, @user.verified
  end

  test "verification should render verification view if token does match" do
    # setup sets headers to application/json by default since it's normally
    # just responding to API requests so we need to override for this test
    @request.headers["Accept"] = "text/html"
    @request.headers["Content-Type"] = "text/html"

    get :index, { "signature" => "", "token" => "" }

    assert_response :ok
    assert_template :index
  end

end
