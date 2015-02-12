require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase
  should validate_presence_of :message
  should validate_presence_of :token

  # TODO: Find best way to test uniquness on these two attributes
  # should validate_uniqueness_of :message
  # should validate_uniqueness_of :token

  test "should validate uniquness" do
    skip "Write test directly above"
  end

  test "should respond to generate_message_and_token" do
    @authentication = authentications(:one)
    assert_respond_to @authentication, :generate_message_and_token
  end
end
