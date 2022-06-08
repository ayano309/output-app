Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resource :profile, only: [:show, :edit, :update]
  resource :articles
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
