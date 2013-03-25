Cavy::Engine.routes.draw do
  
  root to: 'pages#page'

  get '/admin',     to: 'admin#overview',   as: 'admin_overview'
  get '/users',     to: 'admin#users',      as: 'admin_users'
  get '/pages',     to: 'admin#pages',      as: 'admin_pages'
  get '/new_page',  to: 'admin#new_page',   as: 'admin_new_page'

  get ':title',     to: 'pages#page',       as: 'page'

end
