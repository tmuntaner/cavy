module Cavy
  module Permissions
    class GuestPermission < BasePermission
      
      def initialize
        allow 'cavy/pages',       [:page]
        allow 'cavy/sessions',    [:new, :create, :destroy]
        allow 'cavy/first_time',  [:welcome, :new_user, :create_user]
      end

    end
  end
end