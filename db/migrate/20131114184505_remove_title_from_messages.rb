class RemoveTitleFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :title, :string, null: false
  end
end
