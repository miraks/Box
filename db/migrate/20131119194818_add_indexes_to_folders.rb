class AddIndexesToFolders < ActiveRecord::Migration
  def up
    add_index :folders, :user_id
    execute <<-QUERY
      CREATE INDEX index_folders_on_parent_folder_ids_first
        ON folders
        USING btree
        ((parent_folder_ids[1]))
    QUERY
  end

  def down
    remove_index :folders, :user_id
    execute <<-QUERY
      DROP INDEX index_folders_on_parent_folder_ids_first
    QUERY
  end
end
