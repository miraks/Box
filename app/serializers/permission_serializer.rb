class PermissionSerializer < ActiveModel::Serializer
  attributes :permission, :id

  def permission
    # TODO: fixit
    object.permission scope if object.respond_to? :permission
  end
end