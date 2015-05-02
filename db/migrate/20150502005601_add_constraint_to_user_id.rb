class AddConstraintToUserId < ActiveRecord::Migration
  def change
    change_column_null :secrets, :user_id, false
  end
end
