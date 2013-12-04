UploadPolicy = Struct.new(:user, :upload) do
  include PermissionCheck

  self.item = :upload

  def create?
    user == upload.folder.user
  end
  alias :update? :create?

  def download? password = nil
    has_permission? password
  end
end