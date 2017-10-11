module Cavy
  module Permissions
    class BasePermission

      def allow?(controller, action, resource = nil)
        allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
        allowed && (allowed == true || resource && allowed.call(resource))
      end

      def allow_all
        @allow_all = true
      end

      def allow(controllers, actions)
        @allowed_actions ||= {}
        Array(controllers).each do |controller|
          Array(actions).each do |action|
            @allowed_actions[[controller.to_s, action.to_s]] = true
          end
        end
      end

      def allow_param(resources, attributes)
        @allowed_params ||= {}
        Array(resources).each do |resource|
          @allowed_params[resource] ||= []
          @allowed_params[resource] += Array(attributes)
        end
      end

      def allow_param?(resource, attribute)
        if @allow_all
          true
        elsif @allowed_params && @allowed_params[resource]
          @allowed_params[resource].include? attribute
        end
      end

      def permit_params!(params)
        if @allow_all
          params.permit!
        elsif @allowed_params
          @allowed_params.each do |resource, attributes|
            if params[resource].respond_to? :permit
              hstore_data = get_hstore_data(attributes, params[resource])
              params[resource] = params[resource].permit(*attributes)
              params[resource].merge!(hstore_data)
              params.permit!
            end
          end
        end
      end

      private

      def get_hstore_data(attributes, resource)
        hstore_data = {}
        attributes.each do |attribute|
          if attribute.class == Hash and resource[attribute.keys.first]
            hstore_data[attribute.keys.first] = resource[attribute.keys.first]
          end
        end
        hstore_data
      end

    end
  end
end
