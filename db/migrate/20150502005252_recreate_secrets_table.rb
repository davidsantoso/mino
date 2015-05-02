class RecreateSecretsTable < ActiveRecord::Migration
  def change
    drop_table :secrets

    create_table :secrets do |t|
      t.integer :user_id
      t.string  :name
      t.string  :url
      t.string  :username, null: false
      t.string  :password, null: false
      t.text    :notes
      t.timestamps null: false
    end

    add_index :secrets, :user_id
  end
end
