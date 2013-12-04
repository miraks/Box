class Conversation < Struct.new(:user1, :user2)
  include ActiveModel::SerializerSupport

  attr_accessor :id
  attr_writer   :last_message

  def initialize user1, user2
    super
    self.id = generate_id
  end

  def self.of user
    Message.not_deleted_by(user).last_in_conversations(user).order('messages.id desc').with_users.map do |message|
      conversation = Conversation.new(message.user, message.recipient)
      conversation.last_message = message
      conversation
    end
  end

  def self.mark_unread user, conversations
    unread_ids = Message.unread_by(user).where(conversation_id: conversations.map(&:id)).pluck('DISTINCT(conversation_id)')
    conversations.each do |conversation|
       conversation.set_unread user, unread_ids.include?(conversation.id)
    end
  end

  def messages user = nil
    messages = Message.where conversation_id: id
    messages = messages.not_deleted_by user if user
    messages
  end

  def unread user
    @unread ||= {}
    @unread.fetch(number(user)) { messages.unread_by(user).exists? }
  end

  def set_unread user, value
    @unread ||= {}
    @unread[number(user)] = value
  end

  def last_message
    @last_message ||= messages.last
  end

  def other user
    user1 == user ? user2 : user1
  end

  def read user
    messages.unread_by(user).update_all read_at: Time.now
  end

  private

  def generate_id
    [user1, user2].sort.map(&:slug).join('_')
  end

  def number user
    user == user1 ? :user2 : :user1
  end
end