Rails.application.routes.draw do
  resources :users, only: [:create, :update, :destroy]
  resources :verifications, only: [:index]
end
