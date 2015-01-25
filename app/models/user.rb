class User < ActiveRecord::Base
  validates_presence_of :email, :public_key, :encrypted_private_key
  validates_uniqueness_of :email, :public_key, :encrypted_private_key

  before_create :setup_email_verification
  after_create :send_verification_token

  def setup_email_verification
    self.verified = false
    self.email_verification_token = SecureRandom.urlsafe_base64(64, true)
  end

  def send_verification_token
  end
end
