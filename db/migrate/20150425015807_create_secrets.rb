class CreateSecrets < ActiveRecord::Migration
  def change
    create_table :secrets do |t|
      t.string :name
      t.string :url
      t.string :username
      t.string :password
      t.text   :notes
      t.timestamps null: false
    end
  end
end
