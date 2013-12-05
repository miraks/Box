Friend = Struct.new(:user) do
  def friend_of? other_user
    user.friends.include? other_user
  end

  def considered_friend_by? other_user
    other_user.friend_of? user
  end

  def has_friends?
    user.friends.exists?
  end

  def become_friend_with other_user
    Friendship.create user: user, friend: other_user
  end

  def stop_being_friend_of other_user
    friendship = friendship_with(other_user).destroy
  end

  def friendship_with other_user
    friendship = user.friendships.with(other_user)
    friendship.last ? friendship.last : friendship.new
  end

  def online_friends
    ids = user.friendships.pluck(:friend_id)
    return User.none if ids.empty?
    times = Onliner.last_online_time ids
    ids = ids.zip(times).select { |(id, time)| Onliner.online? time }.map(&:first)
    User.where id: ids
  end
end
