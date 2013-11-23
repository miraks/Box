module RedisConnection
  class Set
    include Connector

    attr_reader :name

    def initialize name
      @name = name
    end

    def all
      connection.smembers @name
    end

    def push *values
      connection.sadd @name, values
    end

    def pop
      connection.spop @name
    end

    def include? value
      connection.sismember @name, value
    end

    def remove *values
      connection.srem @name, values
    end

  end
end