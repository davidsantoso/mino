require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase
  should validate_presence_of :challenge

  # TODO: Find best way to test uniquness on these two attributes
  # should validate_uniqueness_of :challenge
  # should validate_uniqueness_of :token

  test "should validate uniquness" do
    skip "Write test directly above"
  end

  test "should respond to generate_challenge" do
    @authentication = authentications(:one)
    assert_respond_to @authentication, :generate_challenge
  end

  test "should respond to encrypted_challenge" do
    @authentication = authentications(:one)
    assert_respond_to @authentication, :encrypted_challenge
  end

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
