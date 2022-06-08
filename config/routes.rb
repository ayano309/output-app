Rails.application.routes.draw do
  devise_for :users
  root to: "articles#index"
  resource :profile, only: [:show, :edit, :update]
  resources :articles do
    #resourceになることに注意！！！１人のユーザーが１つの投稿に１個のいいね
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy] 
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
