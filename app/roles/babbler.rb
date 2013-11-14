Babbler = Struct.new(:user) do
  def conversation_with other_user
    Conversation.new user, other_user
  end

  def unread_messages_count
    Message.where(recipient: user, read_at: nil).count
  end
end