class Client < ActiveRecord::Base
  validates_uniqueness_of :signature
  validates_presence_of :signature
  validates_presence_of :user_id

  after_create :send_verification_email

  belongs_to :user
  has_many :verifications, as: :verifiable, dependent: :destroy

  def send_verification_email
    verification = self.verifications.create
    VerificationMailer.verify_client(self.user.email, self.signature, verification.token).deliver_later
  end

  def verify(params)
    if self.signature == params[:signature]
      self.verified = true
      self.enabled = true
      save
    else
      false
    end
  end
end
