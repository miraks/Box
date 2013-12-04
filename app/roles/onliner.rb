Onliner = Struct.new(:user) do
  class_attribute :online_bound, instance_writer: false

  self.online_bound = 10.minutes.freeze

  def online!
    storage[user.id] = Time.now.to_i
  end

  def online?
    self.class.online? last_online_time
  end

  def last_online_time
    self.class.last_online_time user.id
  end

  def self.online? time
    (time and time > online_bound.ago.to_time) or false
  end

  def self.last_online_time ids
    times = storage.get *ids
    times.map! { |time| time ? Time.at(time.to_i) : nil }
    times.one? ? times.first : times
  end

  private

  def self.storage
    @storage ||= RedisConnection::Hash.new 'online_users'
  end
  delegate :storage, to: :class

end