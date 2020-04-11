Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'account#login'
  resources :account
  resources :gsearch
  resources :sessions, only: [:new, :create, :destroy]
  post 'signup', to: 'account#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'account_menu', to: 'menu#menu', as: 'menu'
  get 'gmap', to:'gmap#map', as: 'gmap'
  post 'gmap/search', to:'gmap#results', as: 'gmap_search'

  get '/auth/:provider/callback', to: 'sessions#omniauth'
end
