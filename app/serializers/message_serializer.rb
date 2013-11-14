class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :conversation_id, :unread

  def unread
    object.read_at?
  end

  has_one :user
  has_one :recipient
end
