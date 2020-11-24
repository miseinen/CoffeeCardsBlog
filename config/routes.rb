Rails.application.routes.draw do
  root to: "pages#index"
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get "/", to: "pages#index", as: :locale_root
    resources :coffeecards
    get "signup", to: "users#new"
    resources :users, except: [:new]
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
  end
end
