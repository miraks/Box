class FriendshipSerializer < ActiveModel::Serializer
  attributes :id

  has_one :friend, serializer: FriendSerializer
end
