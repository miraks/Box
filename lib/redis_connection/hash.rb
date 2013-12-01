module RedisConnection
  class Hash < Structure
    def [] key
      connection.hget name, key
    end

    def []= key, value
      connection.hset name, key, value
    end

    def get *keys
      connection.hmget name, keys
    end

    def set hash
      connection.hmset name, hash.to_a.flatten
    end

    def has_key? key
      connection.hexists name, key
    end

    def all
      connection.hgetall name
    end

    def delete key
      connection.hdel name, key
    end
  end
end