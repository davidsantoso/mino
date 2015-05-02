class AddConstraintsToSecrets < ActiveRecord::Migration
  def change
    change_column_null :secrets, :username, false
    change_column_null :secrets, :encrypted_password, false
  end
end
