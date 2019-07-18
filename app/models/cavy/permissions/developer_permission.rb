module Cavy
  module Permissions
    class DeveloperPermission < BasePermission
      def initialize(_user)
        allow_all
      end
    end
  end
end
