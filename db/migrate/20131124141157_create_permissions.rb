class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.integer :owner_id, null: false
      t.integer :user_id
      t.integer :upload_id, null: false
      t.string :permission_type, null: false, default: 'user' # user, group, friends etc.
      t.timestamps
    end
  end
end