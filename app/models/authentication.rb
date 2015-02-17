class Authentication < ActiveRecord::Base
  validates_presence_of :challenge

  belongs_to :user

  after_initialize :generate_challenge
  before_save :validate_user_is_verified

  def generate_challenge
    self.challenge = SecureRandom.hex(32)
  end

  def validate_user_is_verified
    errors.add(:user_id, "email address has not been verified") if !self.user.verified
  end
end
