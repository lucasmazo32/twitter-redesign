Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, except: %i[show]
  scope 'me', as: 'me' do
    get '/:id', to: 'users#show'
    delete '/:id', to: 'users#destroy'
  end
  resources :jlt,only: %i[index show]
  post '/jlt/new', to: 'jlt#create'
  post '/jlt/foreign', to: 'jlt#foreign'
  post '/me/:id', to: 'jlt#followers'
  get '/me', to: 'users#me'
  root 'jlt#index'
end
