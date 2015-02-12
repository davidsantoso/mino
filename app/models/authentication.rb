class Authentication < ActiveRecord::Base
  validates_presence_of :message, :token
  validates_uniqueness_of :message, :token

  belongs_to :user

  after_initialize :generate_message_and_token

  def generate_message_and_token
    self.message = SecureRandom.hex(32)
    self.token = SecureRandom.hex(32)
  end
end
