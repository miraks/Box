class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :conversation_id, :created_at

  has_one :user
  has_one :recipient
end
