class AddFileProcessingToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :file_processing, :boolean
  end
end
