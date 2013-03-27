module Cavy
  module Permissions
    class ClientPermission < BasePermission

      def initialize(user)
        allow 'cavy/pages',       [:page, :edit, :update]
        allow 'cavy/sessions',    [:new,:create,:destroy]
        allow 'cavy/admin',       [:overview, :users, :new_user]
        allow 'cavy/admin_pages', [:index, :show, :update, :edit]
        allow 'cavy/mercury',     [:edit, :resource, :snippet_options, :snippet_preview, :test_page, :image]
        allow 'cavy/users',       [:index, :show, :new, :edit, :create, :update]
      end

    end
  end
end