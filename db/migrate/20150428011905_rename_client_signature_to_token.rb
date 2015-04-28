class RenameClientSignatureToToken < ActiveRecord::Migration
  def change
    rename_column :clients, :signature, :token
  end
end
