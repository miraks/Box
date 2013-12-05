class UploadPermissionWithUsersSerializer < UploadPermissionSerializer
  has_one :user
end