require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase
  should validate_presence_of(:message)
  should validate_presence_of(:token)

  should validate_uniqueness_of(:message)
  should validate_uniqueness_of(:token)
end
