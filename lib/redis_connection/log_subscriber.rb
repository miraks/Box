module RedisConnection
  class LogSubscriber < ActiveSupport::LogSubscriber
    def initialize
      super
      @odd = false
    end

    def query event
      name, args = event.payload[:name]
      args = event.payload[:args]
      duration = "(#{event.duration.round(1)}ms)"

      if odd?
        name = color name, GREEN, :bold
        duration = color duration, GREEN, :bold
        args = color args, nil, :bold
      else
        name = color name, RED, :bold
        duration = color duration, RED, :bold
      end

      debug "  #{name} #{duration}  #{args}"
    end

    private

    def odd?
      @odd = !@odd
    end
  end
end