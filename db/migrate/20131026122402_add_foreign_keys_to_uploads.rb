class AddForeignKeysToUploads < ActiveRecord::Migration
  def change
    add_foreign_key :uploads, :users
    add_foreign_key :uploads, :folders
  end
end
