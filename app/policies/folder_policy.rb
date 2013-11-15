FolderPolicy = Struct.new(:user, :folder) do
  def show? password = nil
    permission = folder.permission user
    permission == :yes or (permission == :password and folder.password == password)
  end
end