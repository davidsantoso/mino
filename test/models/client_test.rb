require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  should validate_presence_of :user_id
  should validate_presence_of :token
  should validate_uniqueness_of :token
end
