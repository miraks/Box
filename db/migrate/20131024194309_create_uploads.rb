class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :name, null: false
      t.string :original_name, null: false
      t.integer :user_id, null: false
      t.integer :folder_id, null: false

      t.timestamps
    end
  end
end
