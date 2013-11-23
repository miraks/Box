module RedisConnection
  module Connector
    def connection
      Connection.instance.connection
    end
  end
end