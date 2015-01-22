require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:email)
  should validate_presence_of(:public_key)
  should validate_presence_of(:encrypted_private_key)

  should validate_uniqueness_of(:email)
  should validate_uniqueness_of(:public_key)
  should validate_uniqueness_of(:encrypted_private_key)

  test "should trigger setup_email_verification on save" do
    @user = users(:one)

    assert_respond_to @user, :setup_email_verification
    @user.send(:setup_email_verification)

    assert_equal false, @user.verified
    assert_not_empty @user.email_verification_token
  end

  test "should respond to send_verification_token" do
    @user = users(:one)
    assert_respond_to @user, :setup_email_verification

    # Should back fill test stubbing out email send
  end
end
