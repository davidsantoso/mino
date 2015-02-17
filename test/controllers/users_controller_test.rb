require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  setup do
    @request.headers["Accept"] = "application/json"
    @request.headers["Content-Type"] = "application/json"
  end

  test "index should return 403" do
    get :index
    assert_response :forbidden
  end

  test "new should return 403" do
    get :new
    assert_response :forbidden
  end

  test "show should return 403" do
    get :show, {id: 1}
    assert_response :forbidden
  end

  test "edit should return 403" do
    get :edit, {id: 1}
    assert_response :forbidden
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: {email: "daryl.dixon@mail.com", public_key: "PINBwjANBgq", encrypted_private_key: "NUIIWHzdJdb=="}
    end
    user = assigns(:user)

    assert_empty user.errors
    assert_response :success
  end

  test "should return email already taken" do
    post :create, user: {email: "rick.grimes@mail.com", public_key: "MnIdIHANNgk", encrypted_private_key: "TmIcFFWzJBb=="}
    user = assigns(:user)

    assert_not user.valid?
    assert_equal [:email], user.errors.keys
    assert_response :conflict
  end

  test "should return public key already taken" do
    post :create, user: {email: "michonne@mail.com", public_key: "MIIBIjANBgk", encrypted_private_key: "nmIEFdWRmBb=="}
    user = assigns(:user)

    assert_not user.valid?
    assert_equal [:public_key], user.errors.keys
    assert_response :conflict
  end

  test "should return encrypted private key already taken" do
    post :create, user: {email: "michonne@mail.com", public_key: "htIBNjaNKgk", encrypted_private_key: "NmIIFHzBJBb=="}
    user = assigns(:user)

    assert_not user.valid?
    assert_equal [:encrypted_private_key], user.errors.keys
    assert_response :conflict
  end

  # TODO: The after_commit to send the email address verification email should be tested that it is in fact called to be sent.
  #       However, testing an after_commit isn't completely straightfoward at this point. The test_after_commit gem doesn't seem
  #       to work for Rails 4.2. But, it appears it should be included in Rails 5+ (https://github.com/rails/rails/pull/18458).
  #       So, this test needs to be added when possible.
  #
  #       In addition, this test should probably be refactored to test that the job to send the mailer does get enqueued. As of
  #       right now, it's a bit unclear on the best way to test this while using the ActionMailer and ActiveJob integration.
  #
  test "should send email address verification email" do
    skip "Need to figure out how to best test an after_commit callback"
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :create, user: {email: "maggie.greene@mail.com", public_key: "htIBNjeNXgk", encrypted_private_key: "kmIIWHcsJQb=="}
    end
    email_address_verification_email = ActionMailer::Base.deliveries.last

    assert_equal "Verify your mino account", email_address_verification_email.subject
    assert_equal 'maggie.greene@mail.com', email_address_verification_email.to[0]
  end
end
