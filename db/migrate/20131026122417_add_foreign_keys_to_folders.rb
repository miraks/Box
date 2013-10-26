class AddForeignKeysToFolders < ActiveRecord::Migration
  def change
    add_foreign_key :folders, :users
  end
end
