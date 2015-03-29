class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.integer :user_id, null: false
      t.string  :access_token, null: false, limit: 255
      t.string  :email_verification_token, limit: 255
      t.boolean :verified, default: false
      t.boolean :enabled, default: false
      t.timestamps null: false
      t.index :access_token, unique: true
      t.index :user_id
    end
  end
end
