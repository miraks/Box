UploadPolicy = Struct.new(:user, :upload) do
  def download? password = nil
    not upload.password? or user.id == upload.user_id or password == upload.password
  end
end