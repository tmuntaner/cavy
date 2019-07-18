module Cavy
  module Permissions
    class DesignerPermission < BasePermission
      def initialize(_user)
        allow_all
      end
    end
  end
end
