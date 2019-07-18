module Cavy
  module Permissions
    class ClientPermission < BasePermission
      def initialize(_user)
        allow 'cavy/sessions', %i[new create destroy]

        allow 'cavy/pages', %i[page edit update]
        allow 'cavy/admin', %i[dashboard users new_user]
        allow 'cavy/admin_pages', %i[index show update edit add_data create_data]
        allow 'cavy/mercury', %i[edit resource snippet_options snippet_preview test_page image]
        allow 'cavy/users', %i[index show edit update new create]
        allow 'cavy/item_groups', %i[index show edit update update_order]
        allow 'cavy/items', %i[index show new edit create update destroy]
        allow 'cavy/item_sections', %i[index show]
        allow 'cavy/statistics', %i[visitor_history page_view_history]
        allow_param :page, [:title, :description, :tag_string, :key, :value, data: :hstore]
        allow_param :item, [data: :hstore]
      end
    end
  end
end
