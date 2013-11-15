class PermissionSerializer < ActiveModel::Serializer
  attributes :permission

  def permission
    object.permission scope
  end
end