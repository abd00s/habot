Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  resources :goals, only: %w[index create]
  resources :events, only: :create
end
