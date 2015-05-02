class RenamePasswordToEncryptedPassword < ActiveRecord::Migration
  def change
    rename_column :secrets, :password, :encrypted_password
  end
end
