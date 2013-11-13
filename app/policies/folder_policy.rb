FolderPolicy = Struct.new(:user, :folder) do
  def show? password = nil
    not folder.password? or user.id == folder.user_id or password == folder.password
  end
end