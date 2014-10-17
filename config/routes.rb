Rails.application.routes.draw do
  root 'home#index'

  post '/search', to: 'home#search'
end
