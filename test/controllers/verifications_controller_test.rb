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

  test "verification should render verification view if token and email match" do
    # setup sets headers to application/json by default since it's normally
    # just responding to API requests so we need to override for this test
    @request.headers["Accept"] = "text/html"
    @request.headers["Content-Type"] = "text/html"

    get :index, { "email" => "rick.grimes@mail.com", "token" => "DzHrKwgsbw8rIFLtJm25loEE-rY-4yPwxU0IkYbkcF4BIz1BGk50kW0afOx0g6sD0_HRLPJJqARlN4Tj-zU5Iw==" }

    assert_response :ok
    assert_template :index
  end

  test "verification should be expired if email verification passes" do
    get :index, { "email" => "rick.grimes@mail.com", "token" => "DzHrKwgsbw8rIFLtJm25loEE-rY-4yPwxU0IkYbkcF4BIz1BGk50kW0afOx0g6sD0_HRLPJJqARlN4Tj-zU5Iw==" }
    verification = verifications(:one)

    assert_equal true, verification.expired
  end

  test "verification should return 403 if verification token exists but client token does not match" do
    get :index, { "clien_token" => "the_wrong_token", "token" => "gr4yamjzehNf_eKFt9YY0kucAH-XWaH-M0A9yR5mj6Z6cfrqmyvjfAj4Q5kbXoRAs7nUmeVoKXtpv65X9_CWKQ==" }
    assert_response :forbidden
  end

  test "verification should set client to verified true if verification token and client token match" do
    get :index, { "client_token" => "7a7ae245b876a9f00420946aee5b6caf6666ffbb5d1894e9dce5cfa772e2e00a7958049a6653aa207ae6ace9f646c96033b3cc20dc16e6b8cdd275310abdb19f", "token" => "gr4yamjzehNf_eKFt9YY0kucAH-XWaH-M0A9yR5mj6Z6cfrqmyvjfAj4Q5kbXoRAs7nUmeVoKXtpv65X9_CWKQ==" }

    @client = clients(:one)

    assert_response :ok
    assert_equal true, @client.verified
    assert_equal true, @client.enabled
  end

  test "verification should render verification view if verification token and client token match" do
    # setup sets headers to application/json by default since it's normally
    # just responding to API requests so we need to override for this test
    @request.headers["Accept"] = "text/html"
    @request.headers["Content-Type"] = "text/html"

    get :index, { "client_token" => "7a7ae245b876a9f00420946aee5b6caf6666ffbb5d1894e9dce5cfa772e2e00a7958049a6653aa207ae6ace9f646c96033b3cc20dc16e6b8cdd275310abdb19f", "token" => "gr4yamjzehNf_eKFt9YY0kucAH-XWaH-M0A9yR5mj6Z6cfrqmyvjfAj4Q5kbXoRAs7nUmeVoKXtpv65X9_CWKQ==" }

    assert_response :ok
    assert_template :index
  end

  test "verification should be expired if client verification passes" do
    get :index, { "client_token" => "7a7ae245b876a9f00420946aee5b6caf6666ffbb5d1894e9dce5cfa772e2e00a7958049a6653aa207ae6ace9f646c96033b3cc20dc16e6b8cdd275310abdb19f", "token" => "gr4yamjzehNf_eKFt9YY0kucAH-XWaH-M0A9yR5mj6Z6cfrqmyvjfAj4Q5kbXoRAs7nUmeVoKXtpv65X9_CWKQ==" }
    verification = verifications(:two)

    assert_equal true, verification.expired
  end
end
