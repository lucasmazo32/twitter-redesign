Rails.application.routes.draw do
  resources :users, except: %i[show]
  scope 'me', as: 'me' do
    get '/:id', to: 'users#show'
    delete '/:id', to: 'users#destroy'
  end
end
