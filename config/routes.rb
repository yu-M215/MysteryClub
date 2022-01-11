Rails.application.routes.draw do
  # devise関連のルーティング
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }

  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'

  # 検索機能のルーティング
  get 'search' => 'searches#search', as: 'search'

  # 謎解き投稿関連のルーティング
  get 'sort' => 'mysteries#sort', as: 'sort'
  resources :mysteries do
    # コメント機能
    resources :comments, only: %i[create update destroy]
    # いいね機能
    resource :favorites, only: %i[create destroy]
  end

  # 退会機能のルーティング
  # 退会確認画面の表示
  get 'users/unsubscribe/' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  # ユーザーの有効ステータスを更新
  patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'
  put 'users/withdraw' => 'users#withdraw'

  # ユーザーがいいねした投稿の一覧表示
  get 'users/:id/favorites' => 'users#favorites', as: 'favorites_index'

  # ユーザープロフィール関連のルーティング
  resources :users, only: %i[show edit update] do
    resource :relationships, only: %i[create destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  # DM機能のルーティング
  resources :chats, only: %i[show create destroy]

  # 通知一覧画面へのルーティング
  resources :notifications, only: %i[index]
end
