require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "index should return 404" do
    get :index
    assert_response :not_found
  end

  test "new should return 404" do
    get :new
    assert_response :not_found
  end

  test "show should return 404" do
    get :show, {id: 1}
    assert_response :not_found
  end

  test "edit should return 404" do
    get :edit, {id: 1}
    assert_response :not_found
  end
end
