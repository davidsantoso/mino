class RenameExpiredToActive < ActiveRecord::Migration
  def change
    rename_column :authentications, :expired, :active
  end
end
