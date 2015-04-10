class Verification < ActiveRecord::Base
  belongs_to :verifiable, polymorphic: true
end
