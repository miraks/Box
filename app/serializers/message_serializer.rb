class MessageSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :created_at, :unread?

  def unread?
    object.read_at?
  end

  has_one :user
  has_one :recipient
end
