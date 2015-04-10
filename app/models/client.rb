class Client < ActiveRecord::Base
  validates_uniqueness_of :access_token
  validates_presence_of :access_token
  validates_presence_of :user_id

  before_create :setup_email_verification
  after_create :send_verification_email

  belongs_to :user
  has_many :verifications, as: :verifiable, dependent: :destroy

  def setup_email_verification
    self.verified = false
    self.email_verification_token = SecureRandom.urlsafe_base64(64, true)
  end

  def send_verification_email
    ClientMailer.verify_client(self.user.email, self.email_verification_token).deliver_later
  end
end
