module RedisConnection
  class List < Struct
    def push *values
      connection.rpush name, values
    end

    def unshift *values
      connection.lpush name, values
    end

    def shift
      connection.lpop name
    end

    def pop
      connection.rpop name
    end

    def length
      connection.llen name
    end
  end
end