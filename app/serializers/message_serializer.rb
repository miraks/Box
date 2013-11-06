class MessageSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :read_at
end
