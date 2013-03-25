Cavy::Engine.routes.draw do
  
  root to: 'pages#page'

  get '/admin',     to: 'admin#overview',   as: 'admin_overview'
  
  get   '/pages',     to: 'admin#pages',        as: 'admin_pages'
  get   '/new_page',  to: 'admin#new_page',     as: 'admin_new_page'
  post  '/page',      to: 'admin#create_page',  as: 'admin_create_page'
  get   '/page/:id',  to: 'admin#page',         as: 'admin_page'
  put   '/page/:id',  to: 'admin#update_page',  as: 'admin_update_page'

  get '/new_user',  to: 'admin#new_user',     as: 'admin_new_user'
  get '/users',     to: 'admin#users',        as: 'admin_users'

  get ':title',     to: 'pages#page',       as: 'page'

end
