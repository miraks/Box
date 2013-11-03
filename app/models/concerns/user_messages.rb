module UserMessages

  def sent_messages
    messages
  end

  def received_messages
    Message.where(recepient_id: self.id)
  end

end