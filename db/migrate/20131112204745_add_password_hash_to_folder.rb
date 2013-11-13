class AddPasswordHashToFolder < ActiveRecord::Migration
  def change
    add_column :folders, :password_hash, :string
  end
end
