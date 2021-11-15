Rails.application.routes.draw do
  root 'credit_cards#new'
  resources :credit_cards, only: [:create]
  resources :admin, only: [:index]
end
