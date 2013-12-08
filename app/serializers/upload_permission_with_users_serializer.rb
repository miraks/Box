class UploadPermissionWithUsersSerializer < UploadPermissionSerializer
  attributes :upload

  has_one :user

  def upload
    object.item
  end
end