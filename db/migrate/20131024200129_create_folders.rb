class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.integer :parent_folder_ids, array: true, default: []

      t.timestamps
    end
  end
end
