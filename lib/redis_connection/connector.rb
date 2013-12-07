module RedisConnection
  module Connector
    delegate :connection, :create_connection, to: 'RedisConnection::Connection.instance'
  end
end