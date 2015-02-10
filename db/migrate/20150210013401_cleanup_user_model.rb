class CleanupUserModel < ActiveRecord::Migration
  def change
    remove_column :users, :message_to_decrypt
    remove_column :users, :authentication_token
  end
end
