class Authentication < ActiveRecord::Base
  validates_presence_of :message, :token
  validates_uniqueness_of :message, :token

  belongs_to :user
end
