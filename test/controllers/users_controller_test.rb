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

  # This is what the data attribute below should decrypt to
  # {
  #   data: {
  #     email: "daryl.dixon@mail.com",
  #     public_key: "vYSsoH4EAmaSAG3X4RCzbsTqFBa+r6+MQyY6nodR9gY=",
  #     encrypted_private_key: "k/5MxO14VSscJhi7axrEGa9wUYtUpxdihMKIT2vj36g=",
  #     nonce: "hqaf/aSnR6qzW7JIbV4HQZ45XGSm42fp",
  #     salt: "vczSdHujD1A51GAcbFdQZyxc1TIju1EuL79clWdDWBQ="
  #   },
  #   public_key: "vYSsoH4EAmaSAG3X4RCzbsTqFBa+r6+MQyY6nodR9gY=",
  #   nonce: "hqaf/aSnR6qzW7JIbV4HQZ45XGSm42fp"
  # }
  test "should create user" do
    assert_difference('User.count') do
      post :create, {
        data: "OFpy2Ew9Z0kePvkoCkh2RcIuzQVysu8sXMNqiTAaTIHsHLI4IsBq4rCfEzwK0XfroTONCn2GHPSioJRXwkwy3LPV3iTTtw/wiTqWun5NVSsd0ehnwHnheUilUeh66UVYurj86FCkf9EHOd86NmrsVykm4KrgoyhvII+jlsaE6dcD1gKOhR59X3EaGBwj2aAOIqGbDnrTCrwIZa+PaoSuyPjzmA40jEGxQUCCGIz4LYJXdLfG7zRKrw0MZeCzK7p9q2XPtSHi0mXZV2BKakqevn1pe6nt6ObF27GdfCkzbSVeK/ovw5TtrdQmh+EgFS3C3ml/W893UhHPNyBSjVkyKGV3aZc8cwqu1vhqmYqEpJFxiNFnnmC387GhN0Vd",
        public_key: "vYSsoH4EAmaSAG3X4RCzbsTqFBa+r6+MQyY6nodR9gY=",
        nonce: "hqaf/aSnR6qzW7JIbV4HQZ45XGSm42fp"
      }
    end

    user = assigns(:user)

    assert_empty user.errors
    assert_response :success
  end

  test "should return email already taken" do
    skip
    post :create, user: {email: "rick.grimes@mail.com", public_key: "MnIdIHANNgk", encrypted_private_key: "TmIcFFWzJBb==", nonce: "gEn5cq42ci", salt: "ipnEd5n21n"}
    user = assigns(:user)

    assert_not user.valid?
    assert_equal [:email], user.errors.keys
    assert_response :conflict
  end

  test "should return public key already taken" do
    skip
    post :create, user: {email: "michonne@mail.com", public_key: "MIIBIjANBgk", encrypted_private_key: "nmIEFdWRmBb==", nonce: "nnf8bAd83n", salt: "hN8d74s1nA" }
    user = assigns(:user)

    assert_not user.valid?
    assert_equal [:public_key], user.errors.keys
    assert_response :conflict
  end

  test "should return encrypted private key already taken" do
    skip
    post :create, user: {email: "michonne@mail.com", public_key: "htIBNjaNKgk", encrypted_private_key: "NmIIFHzBJBb==", nonce: "lD82nEom82", salt: "ke5oM1bf9A" }
    user = assigns(:user)

    assert_not user.valid?
    assert_equal [:encrypted_private_key], user.errors.keys
    assert_response :conflict
  end

  test "should send email address verification email" do
    skip "Need to figure out how to best test an after_commit callback"
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :create, user: {email: "maggie.greene@mail.com", public_key: "htIBNjeNXgk", encrypted_private_key: "kmIIWHcsJQb==", nonce: "Hm27dm103ma", salt: "nI382bdkKd" }
    end
    email_address_verification_email = ActionMailer::Base.deliveries.last

    assert_enqueued_jobs(1)
    assert_equal "Verify your mino account", email_address_verification_email.subject
    assert_equal 'maggie.greene@mail.com', email_address_verification_email.to[0]
  end
end
