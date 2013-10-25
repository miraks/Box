class AddFileToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :file, :string
    remove_column :uploads, :name, :string
  end
end
