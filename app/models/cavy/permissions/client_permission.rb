module Cavy
  module Permissions
    class ClientPermission < BasePermission

      def initialize(user)
        allow 'cavy/sessions', [:new, :create, :destroy]

        allow 'cavy/pages', [:page, :edit, :update]
        allow 'cavy/admin', [:dashboard, :users, :new_user]
        allow 'cavy/admin_pages', [:index, :show, :update, :edit, :add_data, :create_data]
        allow 'cavy/mercury', [:edit, :resource, :snippet_options, :snippet_preview, :test_page, :image]
        allow 'cavy/users', [:index, :show, :edit, :update, :new, :create]
        allow 'cavy/item_groups', [:index, :show, :edit, :update, :update_order]
        allow 'cavy/items', [:index, :show, :new, :edit, :create, :update, :destroy]
        allow 'cavy/item_sections', [:index, :show]
        allow 'cavy/statistics', [:visitor_history, :page_view_history]
        allow_param :page, [:title, :description, :tag_string, :key, :value, data: :hstore]
        allow_param :item, [data: :hstore]
      end

    end
  end
end