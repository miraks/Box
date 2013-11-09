module CustomFinder
  extend ActiveSupport::Concern

  module ClassMethods
    def find model_name, opts = {}
      model_name = model_name.to_s
      method_name = method_name model_name, opts
      define_finder model_name, method_name, opts
      before_filter method_name, opts
    end

    protected

    def define_finder model_name, method_name, opts
      if singular? model_name
        define_single_finder model_name, method_name, opts
      else
        define_multiple_finder model_name, method_name, opts
      end
    end

    def define_single_finder model_name, method_name, opts
      params_prefix = params_prefix opts
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{method_name}
          id = params#{params_prefix}[:#{model_name}_id] || params#{params_prefix}[:id]
          @#{model_name} ||= #{model_name.camelize}.find id
        end
      CODE
      # def find_user
      #   id = params[:user_id] || params[:id]
      #   @user ||= User.find id
      # end
    end

    def define_multiple_finder model_name, method_name, opts
      params_prefix = params_prefix opts
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{method_name}
          ids = params#{params_prefix}[:#{model_name.singularize}_ids] || params#{params_prefix}[:ids]
          @#{model_name} ||= #{model_name.singularize.camelize}.where id: ids
        end
      CODE
      # def find_users
      #   ids = params[:user_ids] || params[:ids]
      #   @users ||= User.where id: ids
      # end
    end

    private

    def singular? word
      word.singularize == word
    end

    def method_name model_name, opts
      name = "find_#{model_name}"
      name << "_in_#{opts[:in]}" if opts.has_key? :in
      name
    end

    def params_prefix opts
      opts.has_key?(:in) ? "[:#{opts[:in]}]" : ''
    end
  end
end