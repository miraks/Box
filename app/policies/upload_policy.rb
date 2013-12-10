UploadPolicy = Struct.new(:user, :upload) do
  include PermissionCheck

  def owner?
    user == upload.folder.user
  end

  self.item = :upload

  alias :create?  :owner?
  alias :update?  :owner?
  alias :destroy? :owner?

  def download? password = nil
    has_permission? password
  end
end