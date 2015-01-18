class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :email_verification_token
      t.boolean :verified
      t.text    :public_key
      t.text    :encrypted_private_key
      t.string  :password_verification_token
      t.string  :session_token
      t.timestamps null: false
    end
  end
end
