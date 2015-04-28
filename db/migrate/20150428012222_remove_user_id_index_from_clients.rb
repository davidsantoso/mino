class RemoveUserIdIndexFromClients < ActiveRecord::Migration
  def change
    remove_index :clients, :user_id
  end
end
