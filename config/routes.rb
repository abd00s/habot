Rails.application.routes.draw do
  require "sidekiq/web"
  require "sidekiq-scheduler/web"
  mount Sidekiq::Web => "/sidekiq"

  resources :goals, only: %w[index create]
  resources :events, only: :create

  get "dummy", to: "goals#dummy"
end
