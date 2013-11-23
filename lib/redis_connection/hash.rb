module RedisConnection
  class Hash
    include Connector

    attr_reader :name

    def initialize name
      @name = name
    end

    def [] key
      connection.hget @name, key
    end

    def []= key, value
      connection.hset @name, key, value
    end

    def get *keys
      connection.hmget @name, keys
    end

    def set hash
      connection.hmset @name, hash.to_a.flatten
    end

    def has_key? key
      connection.hexists @name, key
    end

    def delete key
      connection.hdel @name, key
    end
  end
end