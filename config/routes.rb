Rails.application.routes.draw do
  resources :users, except: [:index, :show]
  root 'home#index'

  post '/search', to: 'home#search'
end
