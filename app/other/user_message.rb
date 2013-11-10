UserMessage = Struct.new(:user) do
  def sent_messages
    user.messages
  end

  def received_messages
    Message.where(recepient_id: user.id)
  end

  def unread_messages_count
    Message.where(recepient_id: user.id, read_at: nil).count
  end
end