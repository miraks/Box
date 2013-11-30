class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :owner_id, null: false
      t.integer :user_id
      t.integer :item_id, null: false
      t.string :item_type, null: false
      t.string :type
      t.timestamps
    end
  end
end