class RemoveExpiredFromAuthentication < ActiveRecord::Migration
  def change
    remove_column :authentications, :expired
  end
end
