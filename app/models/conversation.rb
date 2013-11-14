class Conversation < Struct.new(:user1, :user2)
  attr_accessor :id

  def initialize user1, user2
    super
    self.id = generate_id
  end

  def messages
    Message.where conversation_id: id
  end

  private

  def generate_id
    [user1, user2].sort.map(&:slug).join('_')
  end
end