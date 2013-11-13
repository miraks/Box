module Roleplayer
  extend ActiveSupport::Concern

  module ClassMethods
    def role name, opts = {}
      define_accessor name
      methods = opts.delete :methods
      delegate *methods, opts.merge(to: name)
    end

    private

    def define_accessor role
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{role}
          @#{role} ||= #{role.to_s.classify}.new self
        end
      CODE
    end
  end
end