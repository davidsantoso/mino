class AddExpiredToVerifications < ActiveRecord::Migration
  def change
    add_column :verifications, :expired, :boolean, default: false
  end
end
