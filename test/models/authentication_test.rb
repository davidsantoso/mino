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
end
