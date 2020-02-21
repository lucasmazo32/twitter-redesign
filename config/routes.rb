Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, except: %i[show]
  scope 'me', as: 'me' do
    get '/:id', to: 'users#show'
    delete '/:id', to: 'users#destroy'
  end
  resources :jlt
  root 'jlt#index'
end
