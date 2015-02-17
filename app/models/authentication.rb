class Authentication < ActiveRecord::Base
  validates_presence_of :challenge

  belongs_to :user

  before_create :validate_user_is_verified

  before_validation(on: :create) do
    self.challenge ||= SecureRandom.hex(32)
  end

  def validate_user_is_verified
    errors.add(:user_id, "email address has not been verified") if !self.user.verified
  end

  def encrypted_challenge
    # Just return the unencrypted challenge for now
    # In the future, this will encrypt it with the public key
    self.challenge
  end

  def activate
    self.active = true
    self.token = SecureRandom.hex(32)
    self.save
  end
end
