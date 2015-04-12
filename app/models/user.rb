class User < ActiveRecord::Base
  validates_presence_of :email, :public_key, :encrypted_private_key, :nonce, :salt
  validates_uniqueness_of :email, :public_key, :encrypted_private_key

  after_create :send_verification_email

  has_many :clients, dependent: :destroy
  has_many :verifications, as: :verifiable, dependent: :destroy

  def send_verification_email
    verification = self.verifications.create
    VerificationMailer.verify_email_address(self.email, verification.token).deliver_later
  end

  def verify(params)
    if self.email == params[:email]
      self.verified = true
      save
    else
      false
    end
  end
end
