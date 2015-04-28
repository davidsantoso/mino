class Client < ActiveRecord::Base
  validates_uniqueness_of :token
  validates_presence_of :token
  validates_presence_of :user_id

  belongs_to :user
  has_many :verifications, as: :verifiable, dependent: :destroy

  def verify(params)
    if self.token == params[:client_token]
      self.verified = true
      self.enabled = true
      save
    else
      false
    end
  end
end
