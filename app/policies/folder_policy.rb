FolderPolicy = Struct.new(:user, :folder) do
  include PermissionCheck

  self.item = :folder

  def show? password = nil
    has_permission? password
  end
end