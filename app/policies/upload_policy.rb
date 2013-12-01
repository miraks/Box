UploadPolicy = Struct.new(:user, :upload) do
  include PermissionCheck

  self.item = :upload

  def download? password = nil
    has_permission? password
  end
end