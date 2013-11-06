module UserMessages

  def sent_messages
    messages
  end

  def received_messages
    Message.where(recepient_id: self.id)
  end

  def unread_messages_count
    Message.where(recepient_id: self.id, read_at: nil).count
  end

end