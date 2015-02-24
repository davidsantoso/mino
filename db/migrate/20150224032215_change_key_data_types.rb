class ChangeKeyDataTypes < ActiveRecord::Migration
  def change
    change_column :users, :public_key, 'bytea USING CAST(public_key AS bytea)'
    change_column :users, :encrypted_private_key, 'bytea USING CAST(encrypted_private_key AS bytea)'
  end
end
