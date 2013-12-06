class FolderPermissionWithUsersSerializer < PermissionSerializer
  has_one :user
end