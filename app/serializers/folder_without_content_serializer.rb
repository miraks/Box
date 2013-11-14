class FolderWithoutContentSerializer < ActiveModel::Serializer
  self.root = 'folder'

  attributes :id, :name, :created_at, :updated_at, :locked
end