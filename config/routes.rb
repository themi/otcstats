Rails.application.routes.draw do

  devise_for :members

  namespace :admin do
    resources :members
  end

  resources :organisations
  resources :graphs do
    collection do
      get 'report'
      get 'csv'
    end
  end
  resources :statistics
  root to: "pages#home"
end
