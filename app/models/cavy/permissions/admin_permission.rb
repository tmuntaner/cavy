module Cavy
  module Permissions
    class AdminPermission < BasePermission
      def initialize(_user)
        allow_all
      end
    end
  end
end
