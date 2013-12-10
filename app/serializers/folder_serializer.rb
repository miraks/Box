class FolderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :locked

  has_many :uploads
  has_many :children, serializer: FolderWithoutContentSerializer
  has_many :parents,  serializer: FolderWithoutContentSerializer
end
