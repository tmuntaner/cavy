Cavy::Engine.routes.draw do
  
  root to: 'pages#page'

  get   '/mercury/:type/:resource', to: "mercury#resource"

  post  '/mercury/image',         to: 'mercury#image',      as: 'mercury_image'

  get   '/admin',                 to: 'admin#overview',     as: 'admin_overview'

  get   '/admin/pages',           to: 'admin#pages',        as: 'admin_pages'
  get   '/admin/new_page',        to: 'admin#new_page',     as: 'admin_new_page'
  post  '/admin/page',            to: 'admin#create_page',  as: 'admin_create_page'
  get   '/admin/page/:id',        to: 'admin#page',         as: 'admin_page'
  put   '/admin/page/:id',        to: 'admin#update_page',  as: 'admin_update_page'
  delete '/admin/page/:id',       to: 'admin#delete_page',  as: 'admin_delete_page'
  get   '/admin/page/edit/:id',   to: 'admin#edit_page',    as: 'admin_edit_page'

  get   '/admin/new_user',        to: 'admin#new_user',     as: 'admin_new_user'
  get   '/admin/users',           to: 'admin#users',        as: 'admin_users'

  post  '/cavy_update/:id',       to: 'pages#update',       as: 'cavy_update_page'
  get   '/edit/:route',           to: 'pages#edit',         as: 'cavy_edit_page'
  get   ':route',                 to: 'pages#page',         as: 'cavy_page'

end
