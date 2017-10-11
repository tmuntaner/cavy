def cavy_locale_scope
  (I18n.available_locales.count > 1) ? '(:locale)' : ''
end

Cavy::Engine.routes.draw do

  scope(cavy_locale_scope, locale: /#{I18n.available_locales.join('|')}/) do


    root to: 'pages#page'

    resources :users

    get '/first_time/welcome', to: 'first_time#welcome', as: 'cavy_first_time_welcome'
    get '/first_time/user', to: 'first_time#new_user', as: 'cavy_first_time_new_user'
    post '/first_time/user', to: 'first_time#create_user', as: 'cavy_first_time_create_user'

    get '/admin', to: 'admin#dashboard', as: 'admin_dashboard'
    get '/system', to: 'admin#system', as: 'admin_system'

    post '/admin/page_templates/:id/field', to: 'admin_page_template_fields#create', as: 'admin_create_page_template_field'
    delete '/admin/page_templates/:id/delete_field/:field', to: 'admin_page_template_fields#delete', as: 'admin_delete_page_template_field'

    get '/admin/page_templates', to: 'admin_page_templates#index', as: 'admin_page_templates'
    get '/admin/page_template/new', to: 'admin_page_templates#new', as: 'admin_new_page_template'
    post '/admin/page_template', to: 'admin_page_templates#create', as: 'admin_create_page_template'
    get '/admin/page_template/:id', to: 'admin_page_templates#edit', as: 'admin_edit_page_template'
    patch '/admin/page_template/:id', to: 'admin_page_templates#update', as: 'admin_update_page_template'
    delete '/admin/page_template/:id', to: 'admin_page_templates#delete', as: 'admin_delete_page_template'

    get '/admin/pages', to: 'admin_pages#index', as: 'admin_pages'
    get '/admin/new_page', to: 'admin_pages#new', as: 'admin_new_page'
    post '/admin/page', to: 'admin_pages#create', as: 'admin_create_page'
    get '/admin/page/data/:id', to: 'admin_page_data#new', as: 'admin_add_page_data'
    post '/admin/page/data/:id', to: 'admin_page_data#create', as: 'admin_create_page_data'
    get '/admin/page/:id', to: 'admin_pages#edit', as: 'admin_edit_page'
    put '/admin/page/:id', to: 'admin_pages#update', as: 'admin_update_page'
    delete '/admin/page/:id', to: 'admin_pages#delete', as: 'admin_delete_page'

    get '/admin/item_groups', to: 'item_groups#index', as: 'item_groups'
    get '/admin/item_groups/new', to: 'item_groups#new', as: 'admin_new_item_group'
    get '/admin/item_groups/edit/:id', to: 'item_groups#edit', as: 'admin_edit_item_group'
    post '/admin/item_groups', to: 'item_groups#create', as: 'cavy_create_item_group'
    get '/admin/item_groups/:id', to: 'item_groups#show', as: 'cavy_item_group'
    patch '/admin/item_groups/:id', to: 'item_groups#update', as: 'cavy_update_item_group'
    delete '/admin/item_groups/:id', to: 'item_groups#destroy', as: 'cavy_delete_item_group'
    post '/admin/item_groups/order', to: 'item_groups#update_order', as: 'cavy_update_order_item_group'

    get '/admin/item_sections', to: 'item_sections#index', as: 'cavy_item_sections'
    get '/admin/item_sections/new', to: 'item_sections#new', as: 'cavy_new_item_section'
    get '/admin/item_sections/edit/:id', to: 'item_sections#edit', as: 'cavy_edit_item_section'
    post '/admin/item_sections', to: 'item_sections#create', as: 'cavy_create_item_section'
    patch '/admin/item_section/:id', to: 'item_sections#update', as: 'cavy_update_item_section'
    delete '/admin/item_section/:id', to: 'item_sections#destroy', as: 'cavy_delete_item_section'

    get '/admin/item_sections/:item_section_id/items', to: 'items#edit', as: 'cavy_edit_items'
    post '/admin/item_sections/:item_section_id/item_groups/:item_group_id/items', to: 'items#update', as: 'cavy_update_item'

    get '/admin/signin', to: 'sessions#new', as: 'admin_signin'
    post '/admin/signin', to: 'sessions#create', as: 'admin_create_session'
    get '/admin/signout', to: 'sessions#destroy', as: 'admin_destroy_session'

    get '/admin/new_user', to: 'users#new', as: 'cavy_admin_new_user'
    get '/admin/users', to: 'users#index', as: 'cavy_admin_users'

    get ':route', to: 'pages#page', as: 'cavy_page'
  end

end
