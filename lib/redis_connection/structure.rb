module RedisConnection
  class Structure
    include Connector

    attr_reader :name

    def initialize name
      @name = name
    end

    def exists?
      connection.exists name
    end

    def expire time
      time.kind_of?(Integer) ? connection.expire(name, time) : connection.expireat(name, time.to_i)
    end

    def delete
      connection.del name
    end
  end
end