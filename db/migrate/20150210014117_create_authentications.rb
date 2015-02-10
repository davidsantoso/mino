class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string  :message
      t.string  :token
      t.boolean :expired, default: false
      t.timestamps null: false
    end
  end
end
