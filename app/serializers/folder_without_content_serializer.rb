class FolderWithoutContentSerializer < ActiveModel::Serializer
  self.root = 'folder'

  attributes :id, :name, :locked
end