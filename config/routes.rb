Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }

  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'

  # 謎解き投稿関連のルーティング
  resources :mysteries do
    resources :comments, only:[:create,:destroy]
    resource :favorites, only:[:create,:destroy]
  end

  # 退会機能のルーティング
  # 退会確認画面の表示
  get 'users/unsubscribe/' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  # ユーザーの有効ステータスを更新
  patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'
  put 'users/withdraw' => 'users#withdraw'

  # ユーザープロフィール関連のルーティング
  resources :users, only:[:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  # DM機能のルーティング
  resources :rooms, only:[:show,:create] do
    resources :chats, only: [:create]
  end
end
