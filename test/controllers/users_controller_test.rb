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

    assert_response :success
    assert_empty user.errors
  end

  test "should return email already taken" do
    post :create, user: {email: "rick.grimes@mail.com", public_key: "MnIdIHANNgk", encrypted_private_key: "TmIcFFWzJBb=="}
    user = assigns(:user)

    assert_response :conflict
    assert_not user.valid?
    assert_equal [:email], user.errors.keys
  end
end
