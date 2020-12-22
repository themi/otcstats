Rails.application.routes.draw do

  devise_for :members

  resources :statistics
  resources :graphs do
    collection do
      get 'report'
    end
  end
  resources :members
  resources :organisations

  root to: "pages#home"
end
