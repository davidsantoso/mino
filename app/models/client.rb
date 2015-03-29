class Client < ActiveRecord::Base
  validates_uniqueness_of :access_token
  validates_presence_of :access_token
  validates_presence_of :user_id
end
