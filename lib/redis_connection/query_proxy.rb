module RedisConnection
  class QueryProxy < ActiveSupport::ProxyObject
    include ::Kernel

    def initialize object
      @object = object
    end

    def method_missing name, *args, &block
      _define_proxy_method name
      __send__ name, *args, &block
    end

    private

    def _process_query name, *args
      query_data = { name: name, args: args[1..-1] }
      ::ActiveSupport::Notifications.instrument('query.redis', query_data) { yield }
    end

    def _define_proxy_method name
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{name} *args, &block
          _process_query('#{name}', *args) do
            @object.public_send :#{name}, *args, &block
          end
        end
      CODE
    end
  end
end