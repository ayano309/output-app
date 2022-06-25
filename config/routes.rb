Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks',
  }
  #ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

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
  #通知
  resources :notifications, only: [:index]
  delete '/notifications', to: 'notifications#destroy_all', as: 'notifications_delete'
  #検索
  get '/search', to: 'searches#search'
  #DMチャット
  resources :chats, only: [:show, :create]
  #タイムライン
  resource :timeline, only: [:show]
  #ダッシュボード
  resource :dashboard, only: [:show]
  #グループ
  resources :groups do
    resource :group_users, only: [:create, :destroy]
    #メール作成
    resources :event_notices, only: [:new, :create]
    #送信後の確認画面
    get 'event_notices' => 'event_notices#sent'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
