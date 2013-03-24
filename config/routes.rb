Cavy::Engine.routes.draw do
  
  root to: 'pages#page'

  get '/admin', to: 'pages#admin',  as: 'admin'
  get ':title', to: 'pages#page',   as: 'page'

end
