class FolderSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at
  has_many :uploads
  has_many :children, serializer: FolderWithoutContentSerializer
end
