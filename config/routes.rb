Rails.application.routes.draw do
  resources :users, except: [:index, :show]
  root 'home#index'

  post '/search', to: 'home#search'
  get '/sign_out', to: 'sessions#destroy', as: :sign_out
  get '/sign_in', to: 'sessions#new', as: :sign_in
  post '/sign_in', to: 'sessions#create', as: :login

end
