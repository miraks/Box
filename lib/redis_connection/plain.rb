module RedisConnection
  class Plain
    include Connector
    include Singleton

    def [] key
      connection.get key
    end

    def []= key, value
      connection.set key, value
    end

    def has_key? key
      connection.exists key
    end

    def expire key, time
      time.kind_of?(Integer) ? connection.expire(key, time) : connection.expireat(key, time.to_i)
    end

    def delete *keys
      connection.del keys
    end

    def clear!
      connection.flushall
    end
  end
end