class FriendSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :online?
end
