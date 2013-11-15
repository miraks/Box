Babbler = Struct.new(:user) do
  def unread_messages_count
    Message.unread_by(user).count
  end
end