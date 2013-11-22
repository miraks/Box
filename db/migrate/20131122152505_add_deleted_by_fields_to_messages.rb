class AddDeletedByFieldsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :deleted_by_user, :boolean, default: false
    add_column :messages, :deleted_by_recipient, :boolean, default: false
  end
end
