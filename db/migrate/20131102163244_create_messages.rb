class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id, null: false
      t.integer :recipient_id, null: false
      t.string :title, null: false
      t.text :body
      t.datetime :read_at
      t.timestamps
    end
  end
end