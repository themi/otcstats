Rails.application.routes.draw do

  devise_for :members

  resources :statistics
  resources :graphs
  resources :members
  resources :organisations

  root to: "pages#home"
end
