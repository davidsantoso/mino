require 'test_helper'

class VerificationTest < ActiveSupport::TestCase

  test "should set token before create" do
    user = users(:three)
    verification = user.verifications.create

    assert_not_nil verification.token
    assert_not verification.expired
  end
end
