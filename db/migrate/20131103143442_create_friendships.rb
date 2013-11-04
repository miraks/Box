class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id, null: false
      t.integer :friend_id, null: false

      t.foreign_key :users
      t.foreign_key :users, column: :friend_id

      t.timestamps
    end
  end
end
