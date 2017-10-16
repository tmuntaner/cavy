module Cavy
  module Permissions
    class GuestPermission < BasePermission
      def initialize
        allow 'cavy/pages', [:page]
        allow 'cavy/sessions', %i[new create destroy]
        allow 'cavy/v1/first_time', [:index]
        allow 'cavy/v1/sessions', [:create]
        allow 'cavy/v1/application', [:check_cors]
        allow 'cavy/first_time', %i[welcome new_user create_user]
      end
    end
  end
end
