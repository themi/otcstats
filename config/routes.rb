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

  get 'viewer/:short_url_key', to:  'pages#viewer'
  get 'feedback/:short_url_key', to:  'pages#feedback'
  post 'feedback/:short_url_key', to:  'pages#feedback'
  post 'survey', to:  'pages#survey'
  root to: "pages#home"
end
