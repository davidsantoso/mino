require 'test_helper'

class UsersControllerTest < ActionController::TestCase
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
end
