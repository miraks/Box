class MessageSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :read_at

  has_one :user
  has_one :recipient
end
