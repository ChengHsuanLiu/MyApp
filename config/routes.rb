Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'

  devise_for :users
  get 'rooms/show'
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'rooms#show'
end
