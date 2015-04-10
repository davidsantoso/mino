class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.string :token, null: false
      t.references :verifiable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
