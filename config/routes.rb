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
  get 'account_menu/gmap', to:'gmap#map', as: 'gmap'
  post 'account_menu/gmap/search', to:'gmap#results', as: 'gmap_search'
  get 'account_menu/gmap/search', to:'gmap#map'
  get 'account_menu/chats', to:'chat#index'
  get 'account_menu/chat/new', to:'chat#new'
  post 'account_menu/chat/new', to:'chat#create'
  get 'account_menu/chat/:id/:title/chat', to:'chat#show'
  post 'account_menu/chat/:id/:title/chat', to:'chat#show', as:'showchat'
  post 'account_menu/chat/:id/:title/chat/reply=new', to:'chat#reply', as:'chatreply'
  get 'account_menu/chat/:id/:title/chat/reply=new', to:'chat#reply'
  post 'account_menu/chat/:id/:title/chat/reply=submit', to:'chat#submit', as:'submitreply'
  post 'account_menu/chat/:id/:title/chat/participants', to:'chat#participants', as:'chatusers'
  post 'account_menu/chat/:id/:title/chat/participants/:name/block', to:'chat#ban', as:'chatuserblock'
  get 'account_menu/chat/:id/:title/chat/participants', to:'chat#participants'
  get 'account_menu/chat/:id/:title/chat/delete', to: 'chat#delete', as:'chatdelete'
  get 'account_menu/business', to: 'business#mybizzes', as:'selectbizz'
  get 'account_menu/business/new', to: 'business#add_biz', as:'addbizz'
  post 'account_menu/business/new', to: 'business#add_biz'
  post 'account_menu/business/:name/:address', to: 'business#sel_biz', as:'selbizz'
  post 'account_menu/business/maps', to:'gmap#biz_view', as:'mapview'
  get 'account_menu/gsearch', to:'gsearch#new', as:'gsearch'

  get '/auth/:provider/callback', to: 'sessions#omniauth'
end
