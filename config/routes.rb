Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root 'account#login'
  resources :account
  resources :sessions, only: [:new, :create, :destroy]

  get 'account_auth', to: 'account#auth'
  post 'account_auth', to: 'account#auth'
  get 'account_create', to: 'account#create'
  post 'account_create', to: 'account#create'
  get 'account_menu', to: 'menu#menu', as: 'menu'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'gmap', to:'gmap#map', as: 'gmap'
  post 'gmap/search', to:'gmap#results', as: 'gmap_search'
  #post 'account/create', to: 
  #get 'account-validating', to: 'account#validate'
  #post 'account-validating', to: 'account#validate'
  #get 'account/new', to: 'account#new'
  #post 'signup', to: 'account#new', as: 'signup'
  #get 'login', to: 'sessions#new', as: 'login'

  get '/auth/:provider/callback', to: 'sessions#omniauth'
end
