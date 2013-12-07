module RedisConnection
  class Channel
    include Connector

    attr_reader :name

    def initialize name
      @name = name
    end

    def subscribe
      Thread.new do
        subscribe_connection.subscribe(name) do |on|
          on.message { |_, message| yield message }
        end
      end
    end

    def publish message
      publish_connection.publish name, message
    end

    private

    def subscribe_connection
      @subscribe_connection ||= create_connection :without_proxy
    end

    def publish_connection
      @publish_connection ||= create_connection :without_proxy
    end
  end
end