require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of :email
  should validate_presence_of :public_key
  should validate_presence_of :encrypted_private_key
  should validate_presence_of :nonce
  should validate_presence_of :salt

  should validate_uniqueness_of :email
  should validate_uniqueness_of :public_key
  should validate_uniqueness_of :encrypted_private_key

  test "should respond to send_verification_email" do
    @user = users(:two)
    assert_respond_to @user, :send_verification_email
  end

  test "should send email address verification email" do
    skip "Unit test that a mailer is being properly enqueued"
    user = users(:two)

    assert_enqueued_with(job: SendEmailAddressVerificationTokenJob) do
      user.send_email_address_verification_token
    end
  end
end
