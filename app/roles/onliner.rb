Onliner = Struct.new(:user) do
  class_attribute :online_bound, instance_writer: false

  self.online_bound = 10.minutes.freeze

  def online!
    connection[user.id] = Time.now.to_i
  end

  def online?
    self.class.online? last_online_time
  end

  def last_online_time
    self.class.last_online_time user.id
  end

  def self.online? time
    (time and time > online_bound.ago) or false
  end

  def self.last_online_time id
    value = connection[id]
    return nil unless value.present?
    Time.at value.to_i
  end

  private

  def self.connection
    @connection ||= RedisConnection::Hash.new 'online_users'
  end
  delegate :connection, to: :class

end