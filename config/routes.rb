Cavy::Engine.routes.draw do
  
  resources :users

  if I18n.available_locales.count > 1
    scope "(:locale)", locale: /en|de/ do
      root to: 'pages#page'

      get     '/mercury/:type/:resource', to: "mercury#resource"
      post    '/mercury/image',           to: 'mercury#image',      as: 'mercury_image'

      get     '/admin',                   to: 'admin#overview',     as: 'admin_overview'

      get     '/admin/pages',             to: 'admin_pages#index',  as: 'admin_pages'
      get     '/admin/new_page',          to: 'admin_pages#new',    as: 'admin_new_page'
      post    '/admin/page',              to: 'admin_pages#create', as: 'admin_create_page'
      get     '/admin/page/:id',          to: 'admin_pages#show',   as: 'admin_page'
      put     '/admin/page/:id',          to: 'admin_pages#update', as: 'admin_update_page'
      delete  '/admin/page/:id',          to: 'admin_pages#delete', as: 'admin_delete_page'
      get     '/admin/page/edit/:id',     to: 'admin_pages#edit',   as: 'admin_edit_page'

      get     '/admin/signin',            to: 'sessions#new',       as: 'admin_signin'
      post    '/admin/signin',            to: 'sessions#create',    as: 'admin_create_session'
      delete  '/admin/signout',           to: 'sessions#destroy',   as: 'admin_destroy_session'

      get     '/admin/new_user',          to: 'admin#new_user',     as: 'admin_new_user'
      get     '/admin/users',             to: 'admin#users',        as: 'admin_users'

      put     '/cavy_update/:id',        to: 'pages#update',       as: 'cavy_update_page'
      get     '/edit/:route',            to: 'pages#edit',         as: 'cavy_edit_page'
      get     ':route',                  to: 'pages#page',         as: 'cavy_page'
    end
  else
    get     '/mercury/:type/:resource', to: "mercury#resource"
    post    '/mercury/image',           to: 'mercury#image',      as: 'mercury_image'

    get     '/admin',                   to: 'admin#overview',     as: 'admin_overview'

    get     '/admin/pages',             to: 'admin_pages#index',  as: 'admin_pages'
    get     '/admin/new_page',          to: 'admin_pages#new',    as: 'admin_new_page'
    post    '/admin/page',              to: 'admin_pages#create', as: 'admin_create_page'
    get     '/admin/page/:id',          to: 'admin_pages#show',   as: 'admin_page'
    put     '/admin/page/:id',          to: 'admin_pages#update', as: 'admin_update_page'
    delete  '/admin/page/:id',          to: 'admin_pages#delete', as: 'admin_delete_page'
    get     '/admin/page/edit/:id',     to: 'admin_pages#edit',   as: 'admin_edit_page'

    get     '/admin/signin',            to: 'sessions#new',       as: 'admin_signin'
    post    '/admin/signin',            to: 'sessions#create',    as: 'admin_create_session'
    delete  '/admin/signout',           to: 'sessions#destroy',   as: 'admin_destroy_session'

    get     '/admin/new_user',          to: 'admin#new_user',     as: 'admin_new_user'
    get     '/admin/users',             to: 'admin#users',        as: 'admin_users'

    put     '/cavy_update/:id',        to: 'pages#update',       as: 'cavy_update_page'
    get     '/edit/:route',            to: 'pages#edit',         as: 'cavy_edit_page'
    get     ':route',                  to: 'pages#page',         as: 'cavy_page'
  end

end
