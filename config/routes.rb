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
  get 'account_menu/chats', to:'chat#index'
  get 'account_menu/chat/new', to:'chat#new'
  post 'account_menu/chat/new', to:'chat#create'
  get 'account_menu/chat/:id/:title/show', to:'chat#show'
  post 'account_menu/chat/:id/:title/show', to:'chat#show', as: 'showchat'

  get '/auth/:provider/callback', to: 'sessions#omniauth'
end
