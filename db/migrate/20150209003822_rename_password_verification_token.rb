class RenamePasswordVerificationToken < ActiveRecord::Migration
  def change
    rename_column :users, :password_verification_token, :message_to_decrypt
  end
end
