class RemoveVerificationTokenFromClientsAndUsers < ActiveRecord::Migration
  def change
    remove_column :clients, :email_verification_token
    remove_column :users, :email_verification_token
  end
end
