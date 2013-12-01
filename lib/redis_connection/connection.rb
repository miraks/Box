module RedisConnection
  class Connection
    include Singleton

    attr_reader :connection

    # don't worry redis gem is thread-safe
    def initialize
      connection = Redis.new config
      @connection = QueryProxy.new connection
    end

    def clear!
      connection.flushall
    end

    private

    def config
      return @config if @config
      path = Rails.root.join 'config/redis.yml'
      erb = Erubis::Eruby.new path.read
      @config = YAML.load erb.result(binding)
    end
  end
end