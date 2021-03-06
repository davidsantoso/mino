class AddSaltToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :created_at
    remove_column :users, :updated_at
    add_column :users, :salt, :string, null: false
    add_column :users, :created_at, :datetime, null: false
    add_column :users, :updated_at, :datetime, null: false
  end
end
