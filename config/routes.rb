def cavy_locale_scope
  if I18n.available_locales.count > 1
    return "(:locale)"
  else
    return ''
  end
end

Cavy::Engine.routes.draw do
  
  resources :item_sections

  scope(cavy_locale_scope, locale: /#{I18n.available_locales.join('|')}/) do
      root to: 'pages#page'

      resources :users

      get     '/mercury/:type/:resource',   to: 'mercury#resource'
      post    '/mercury/image',             to: 'mercury#image',            as: 'mercury_image'

      get     '/admin',                     to: 'admin#overview',           as: 'admin_overview'
      get     '/first_time',                to: 'admin#first_time',         as: 'cavy_first_time'
      get     '/admin/pages',               to: 'admin_pages#index',        as: 'admin_pages'
      get     '/admin/new_page',            to: 'admin_pages#new',          as: 'admin_new_page'
      post    '/admin/page',                to: 'admin_pages#create',       as: 'admin_create_page'
      get     '/admin/page/:id',            to: 'admin_pages#show',         as: 'admin_page'
      put     '/admin/page/:id',            to: 'admin_pages#update',       as: 'admin_update_page'
      delete  '/admin/page/:id',            to: 'admin_pages#delete',       as: 'admin_delete_page'
      get     '/admin/page/edit/:id',       to: 'admin_pages#edit',         as: 'admin_edit_page'
      get     '/admin/page/data/:id',       to: 'admin_pages#add_data',     as: 'admin_add_page_data'
      post    '/admin/page/data/:id',       to: 'admin_pages#create_data',  as: 'admin_create_page_data'
      
      get     '/admin/item_group',          to: 'item_groups#index',        as: 'item_groups'
      get     '/admin/item_group/new',      to: 'item_groups#new',          as: 'admin_new_item_group'
      get     '/admin/item_group/edit/:id', to: 'item_groups#edit',         as: 'admin_edit_item_group'
      post    '/admin/item_group',          to: 'item_groups#create',       as: 'cavy_create_item_group'
      get     '/admin/item_group/:id',      to: 'item_groups#show',         as: 'cavy_item_group'
      patch   '/admin/item_group/:id',      to: 'item_groups#update',       as: 'cavy_update_item_group'
      delete  '/admin/item_group/:id',      to: 'item_groups#destroy',      as: 'cavy_delete_item_group'
      post    '/admin/item_group/order',    to: 'item_groups#update_order', as: 'cavy_update_order_item_group'

      get     '/admin/item/new/:group_id',  to: 'items#new',                as: 'cavy_new_item'
      post    '/admin/item/new/:group_id',  to: 'items#create',             as: 'cavy_create_item'
      get     '/admin/item/:id',            to: 'items#show',               as: 'cavy_item'
      patch   '/admin/item/:id',            to: 'items#update',             as: 'cavy_update_item'
      delete  '/admin/item/:id',            to: 'items#destroy',            as: 'cavy_delete_item'
      get     '/admin/item/edit/:id',       to: 'items#edit',               as: 'cavy_edit_item'

      get     '/admin/signin',              to: 'sessions#new',             as: 'admin_signin'
      post    '/admin/signin',              to: 'sessions#create',          as: 'admin_create_session'
      delete  '/admin/signout',             to: 'sessions#destroy',         as: 'admin_destroy_session'

      get     '/admin/new_user',            to: 'users#new',                as: 'cavy_admin_new_user'
      get     '/admin/users',               to: 'users#index',              as: 'cavy_admin_users'

      post    '/cavy_update/:id',           to: 'pages#update',             as: 'cavy_update_page'
      get     '/edit/:route',               to: 'pages#edit',               as: 'cavy_edit_page'
      get     ':route',                     to: 'pages#page',               as: 'cavy_page'

    end

end
