class User < ActiveRecord::Base
  validates_presence_of :email, :public_key, :encrypted_private_key, :nonce, :salt
  validates_uniqueness_of :email, :public_key, :encrypted_private_key

  has_many :clients, dependent: :destroy
  has_many :verifications, as: :verifiable, dependent: :destroy

  def verify(params)
    if self.email == params[:email]
      self.verified = true
      save
    else
      false
    end
  end
end
