Rails.application.routes.draw do

  devise_for :members

  resources :organisations
  resources :members
  resources :graphs do
    collection do
      get 'report'
      get 'csv'
    end
  end
  resources :statistics
  root to: "pages#home"
end
