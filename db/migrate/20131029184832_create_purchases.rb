class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :user_id, null: false
      t.integer :upload_id, null: false
      t.string :upload_name, null: false
      t.timestamps
    end
  end
end