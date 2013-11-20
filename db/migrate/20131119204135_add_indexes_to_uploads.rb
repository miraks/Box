class AddIndexesToUploads < ActiveRecord::Migration
  def change
    add_index :uploads, :folder_id
  end
end
