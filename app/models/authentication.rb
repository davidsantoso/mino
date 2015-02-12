class Authentication < ActiveRecord::Base
  validates_presence_of :message, :token

  belongs_to :user

  after_initialize :generate_message_and_token
  before_save :validate_user_is_verified

  def generate_message_and_token
    self.message = SecureRandom.hex(32)
    self.token = SecureRandom.hex(32)
  end

  def validate_user_is_verified
    errors.add(:user_id, "email address has not been verified") if !self.user.verified
  end
end
