module Cavy
  module Permissions
    class GuestPermission < BasePermission
      def initialize
        allow 'cavy/pages', [:page]
        allow 'cavy/sessions', [:new,:create,:destroy]
        allow 'cavy/admin',     [:first_time]
      end
    end
  end
end