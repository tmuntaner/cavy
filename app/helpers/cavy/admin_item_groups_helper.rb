module Cavy
  module AdminItemGroupsHelper

    def form_path(params, id)
      if params[:action] == 'new' || params[:action] == 'create'
        return cavy_create_item_path(group_id: params[:group_id])
      elsif params[:action] == 'edit' || params[:action] == 'update'
        return cavy_update_item_path(id)
      end
    end

    def form_method(params)
      if params[:action] == 'new' || params[:action] == 'create'
        return 'post'
      elsif params[:action] == 'edit' || params[:action] == 'update'
        return 'patch'
      end
    end
  end
end
