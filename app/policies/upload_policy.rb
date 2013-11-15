UploadPolicy = Struct.new(:user, :upload) do
  def download? password = nil
    permission = upload.permission user
    permission == :yes or (permission == :password and upload.password == password)
  end
end