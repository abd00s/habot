Rails.application.routes.draw do
  resources :goals, only: %w[index create]
  get :ping, to: "events#ping"
  resources :events, only: :create
end
