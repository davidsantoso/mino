require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  should validate_presence_of :user_id
  should validate_presence_of :access_token
  should validate_uniqueness_of :access_token

  test "should trigger setup_email_verification on save" do
    @client = clients(:one)

    assert_respond_to @client, :setup_email_verification
    @client.send(:setup_email_verification)

    assert_equal false, @client.verified
    assert_not_empty @client.email_verification_token
  end

  test "should respond to send_email_address_verification_token" do
    @client = clients(:one)
    assert_respond_to @client, :send_verification_email
  end

  test "should send email_address_verification email" do
    skip "Unit test that a mailer is being sent out"
    @client = clients(:two)

    assert_enqueued_with(job: SendClientVerificationJob) do
      @client.send_client_verification_email
    end
  end
end
