module Cavy
  module Permissions
    class DesignerPermission < BasePermission

      def initialize(user)
        allow_all
      end

    end
  end
end