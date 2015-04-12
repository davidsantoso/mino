class RenameAccessTokenToSignature < ActiveRecord::Migration
  def change
    rename_column :clients, :access_token, :signature
  end
end
