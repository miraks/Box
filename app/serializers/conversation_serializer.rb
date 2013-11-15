class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :unread, :updated_at

  def unread
    object.unread scope
  end

  def updated_at
    object.last_message.created_at
  end
end
