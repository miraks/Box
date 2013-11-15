Manipulable = Struct.new(:upload) do
  def move new_folder
    upload.folder = new_folder
    upload.save
  end

  def copy new_folder
    upload_copy = upload.dup
    # TODO: Возможно стоит хранить symlink на файл, надо обсудить
    upload_copy.file = upload.file
    upload_copy.folder = new_folder
    upload_copy.user = new_folder.user
    upload_copy.save
  end

end