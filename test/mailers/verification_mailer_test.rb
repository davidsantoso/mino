require 'test_helper'

class VerificationMailerTest < ActionMailer::TestCase
  test "verify email address mailer should have the correct fields" do
    email = VerificationMailer.verify_email_address("glenn.rhee@example.com", "b3Eqmc9rnKDfOo30fnJklF").deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['from@example.com'], email.from
    assert_equal ['glenn.rhee@example.com'], email.to
    assert_equal 'Verify your mino account', email.subject

    assert_match(/Hello./, email.body.to_s)
    assert_match(/token=b3Eqmc9rnKDfOo30fnJklF/, email.body.to_s)
    assert_match(/email=glenn.rhee@example.com/, email.body.to_s)
  end
end
