Rails.application.routes.draw do
  resources :goals, only: %w[index create]
end
