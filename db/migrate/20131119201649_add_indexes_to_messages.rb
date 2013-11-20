class AddIndexesToMessages < ActiveRecord::Migration
  def change
    add_index :messages, [:user_id]
    add_index :messages, [:conversation_id]
    add_index :messages, [:recipient_id, :read_at, :conversation_id]
  end
end
