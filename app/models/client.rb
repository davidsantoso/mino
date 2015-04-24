class Client < ActiveRecord::Base
  validates_uniqueness_of :signature
  validates_presence_of :signature
  validates_presence_of :user_id

  belongs_to :user
  has_many :verifications, as: :verifiable, dependent: :destroy

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
