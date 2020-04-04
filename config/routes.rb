Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'gsearch#google_search'
  resources :account
  resources :gsearch
end
