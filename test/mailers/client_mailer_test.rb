require 'test_helper'

class ClientMailerTest < ActionMailer::TestCase
  test "verify client" do
    email = ClientMailer.verify_client("carol.peletier@example.com", "bdcb7d52e95dee6ddac8c8282c7a6106cf9ce14567e1ccba225cf361a85de86999df08eb200aa093109beaf028fb1e1827c36b4ae563c5b13addc32a52cd89f5").deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    assert_equal ['from@example.com'], email.from
    assert_equal ['carol.peletier@example.com'], email.to
    assert_equal 'Verify your recent login attempt', email.subject

    assert_match(/Hello./, email.body.to_s)
    assert_match(/token=bdcb7d52e95dee6ddac8c8282c7a6106cf9ce14567e1ccba225cf361a85de86999df08eb200aa093109beaf028fb1e1827c36b4ae563c5b13addc32a52cd89f5/, email.body.to_s)
    assert_match(/email=carol.peletier@example.com/, email.body.to_s)
  end
end
