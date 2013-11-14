class FolderSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at, :locked

  has_many :uploads
  has_many :children, serializer: FolderWithoutContentSerializer
  has_many :parents,  serializer: FolderWithoutContentSerializer
end
