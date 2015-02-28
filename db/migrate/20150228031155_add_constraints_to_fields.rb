class AddConstraintsToFields < ActiveRecord::Migration
  def change
    change_column :authentications, :user_id, :integer, null: false
    change_column :authentications, :challenge, :string, limit: 255
    change_column :authentications, :token, :string, limit: 255
    change_column :users, :email, :string, null: false, limit: 255
    change_column :users, :email_verification_token, :string, limit: 255
    change_column :users, :public_key, :text, null: false
    change_column :users, :encrypted_private_key, :text, null: false
  end
end
