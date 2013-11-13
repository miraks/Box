class AddPasswordHashToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :password_hash, :string
  end
end
