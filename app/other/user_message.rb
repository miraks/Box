UserMessage = Struct.new(:user) do
  def sent_messages
    user.messages
  end

  def received_messages
    Message.where(recipient: user)
  end

  def unread_messages_count
    Message.where(recipient: user, read_at: nil).count
  end
end