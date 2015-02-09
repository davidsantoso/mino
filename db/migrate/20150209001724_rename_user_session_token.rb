class RenameUserSessionToken < ActiveRecord::Migration
  def change
    rename_column :users, :session_token, :authentication_token
  end
end
