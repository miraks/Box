class AddForeignKeysToPermissions < ActiveRecord::Migration
  def change
    add_foreign_key :permissions, :users
    add_foreign_key :permissions, :users, column: :owner_id
  end
end
