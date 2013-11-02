module CustomFinder
  extend ActiveSupport::Concern

  module ClassMethods
    def find model_name, opts = {}
      define_finder model_name
      before_filter "find_#{model_name}", opts
    end

    protected

    def define_finder model_name
      class_name = model_name.to_s.camelize
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def find_#{model_name}
          @#{model_name} ||= #{class_name}.find(params[:#{model_name}_id] || params[:id])
        end
      CODE
      # def find_user
      #   @user ||= User.find(params[:user_id] || params[:id])
      # end
    end
  end
end