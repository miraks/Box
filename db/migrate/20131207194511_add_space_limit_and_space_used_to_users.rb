class AddSpaceLimitAndSpaceUsedToUsers < ActiveRecord::Migration
  def up
    add_column :users, :space_limit, :bigint
    User.update_all space_limit: 2.gigabytes
    change_column_null :users, :space_limit, false
    add_column :users, :used_space, :bigint, null: false, default: 0
  end

  def down
    remove_column :users, :used_space
    remove_column :users, :space_limit
  end
end
