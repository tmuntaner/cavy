module Cavy
  module AdminItemGroupsHelper
    def form_path(params, id)
      if params[:action] == 'new' || params[:action] == 'create'
        cavy_create_item_path(group_id: params[:group_id])
      elsif params[:action] == 'edit' || params[:action] == 'update'
        cavy_update_item_path(id)
      end
    end

    def form_method(params)
      if params[:action] == 'new' || params[:action] == 'create'
        'post'
      elsif params[:action] == 'edit' || params[:action] == 'update'
        'patch'
      end
    end
  end
end
