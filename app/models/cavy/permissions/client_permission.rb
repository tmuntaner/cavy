module Cavy
  module Permissions
    class ClientPermission < BasePermission

      def initialize(user)
        allow 'cavy/pages',     [:page]
        allow 'cavy/sessions',  [:new,:create,:destroy]
        allow 'cavy/admin',     [:overview]
        allow 'cavy/admin_pages', [:index]
      end

    end
  end
end