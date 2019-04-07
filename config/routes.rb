Rails.application.routes.draw do
  resources :goals, only: :index
end
