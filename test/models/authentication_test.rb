require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase
  test "should respond to activate" do
    @authentication = authentications(:one)
    assert_respond_to @authentication, :activate
  end

  test "activate should set active to true" do
    @authentication = authentications(:one)
    @authentication.activate
    assert_equal true, @authentication.active
  end

  test "activate should generate token" do
    @authentication = authentications(:one)
    @authentication.activate
    assert_not_nil @authentication.token
  end
end
