class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :created_at
end
