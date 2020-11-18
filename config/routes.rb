Rails.application.routes.draw do
  root to: 'pages#index'
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
end
