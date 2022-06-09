Rails.application.routes.draw do
  devise_for :users
  root to: "articles#index"
  resource :profile, only: [:show, :edit, :update]
  resources :articles do
    #resourceになることに注意！！！１人のユーザーが１つの投稿に１個のいいね
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy] 
  end

  resources :accounts, only: [:index, :show] do
    #フォローする、外す(いいね関係と同じでresourceに注意)
    resource :relationships, only: [:create, :destroy]
    #フォローした人一覧
    get 'followings' => 'relationships#followings', as: 'followings'
    #フォローされた人一覧
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  get '/search', to: 'searches#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
