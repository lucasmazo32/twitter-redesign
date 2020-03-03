Rails.application.routes.draw do
  resources :users
  resources :jlt, only: %i[index show]
  post '/jlt/foreign', to: 'jlt#foreign'
  post '/users/:id', to: 'jlt#followers'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'jlt#index'
end
