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

  # Not really sure if this needs to be tested on the unit level. Probably
  # more helpful if it was tested it within an integration test instead
  #
  # test "should send email address verification email" do
  #   user = users(:two)
  #
  #   assert_enqueued_with(job: SendEmailAddressVerificationTokenJob) do
  #     user.send_email_address_verification_token
  #   end
  # end
end
