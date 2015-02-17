class RenameMessageToChallenge < ActiveRecord::Migration
  def change
    rename_column :authentications, :message, :challenge
  end
end
