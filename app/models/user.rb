class User < ActiveRecord::Base
  validates_presence_of :email, :public_key, :encrypted_private_key, :nonce, :salt
  validates_uniqueness_of :email, :public_key, :encrypted_private_key

  before_create :setup_email_verification
  after_create :send_email_address_verification_token

  def setup_email_verification
    self.verified = false
    self.email_verification_token = SecureRandom.urlsafe_base64(64, true)
  end

  def send_email_address_verification_token
    UserMailer.verify_email_address(self.email, self.email_verification_token).deliver_later
  end

  def email_address_verified?(token)
    if self.email_verification_token == token
      self.verified = true
      self.save
    end
  end
end
