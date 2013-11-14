class AddLockedToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :locked, :boolean, default: false
  end
end
