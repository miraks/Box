class PasswordManager
  attr_reader :item

  def initialize item
    @item = item
  end

  def know_password
    storage.all
  end

  def know_password? user
    donor_storage.include? user.id
  end

  def know_password! user
    donor_storage.push user.id
  end

  def clear!
    storage.delete
  end

  private

  def storage
    @storage ||= storage_for item
  end

  def donor_storage
    @donor_storage ||= storage_for item.password_donor
  end

  def storage_for item
    RedisConnection::Set.new "#{item.class}_#{item.id}"
  end
end