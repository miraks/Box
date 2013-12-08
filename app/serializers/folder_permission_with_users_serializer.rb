class FolderPermissionWithUsersSerializer < PermissionSerializer
  attributes :folder

  has_one :user

  def folder
    object.item
  end
end