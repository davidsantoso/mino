require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:email)
  should validate_presence_of(:public_key)
  should validate_presence_of(:encrypted_private_key)

  should validate_uniqueness_of(:email)
  should validate_uniqueness_of(:public_key)
  should validate_uniqueness_of(:encrypted_private_key)
end
