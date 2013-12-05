class FolderPermissionWithUsersSerializer < PermissionSerializer
  has_many :users
end