Rails.application.routes.draw do
  devise_for :users
  get 'rooms/show'

  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'rooms#show'
  mount ActionCable.server => '/cable'
end
