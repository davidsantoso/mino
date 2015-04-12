class Verification < ActiveRecord::Base
  belongs_to :verifiable, polymorphic: true

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.urlsafe_base64(64, true)
  end
end
