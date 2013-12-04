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

  def self.last_online_time id
    value = storage[id]
    return nil unless value.present?
    Time.at value.to_i
  end

  private

  def self.storage
    @storage ||= Redisstorage::Hash.new 'online_users'
  end
  delegate :storage, to: :class

end