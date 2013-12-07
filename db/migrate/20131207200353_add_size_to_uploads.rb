class AddSizeToUploads < ActiveRecord::Migration
  def up
    add_column :uploads, :size, :integer

    sizes = {}
    Upload.find_each do |upload|
      sizes[upload.id] = { size: upload.file.size }
    end
    Upload.update_numerous sizes

    used_spaces = {}
    User.find_each do |user|
      used_spaces[user.id] = { used_space: user.calculate_used_space }
    end
    User.update_numerous used_spaces

    change_column_null :uploads, :size, false
  end

  def down
    remove_column :uploads, :size
  end
end
