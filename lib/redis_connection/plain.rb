module RedisConnection
  class Plain < Struct
    def get
      connection.get name
    end

    def set value
      connection.set name, value
    end
  end
end