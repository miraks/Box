class AddLockedToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :locked, :boolean, default: false
  end
end
