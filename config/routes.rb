Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'

  resources :mysteries do
    resources :comments, only:[:create,:destroy]
    resource :favorites, only:[:create,:destroy]
  end

  resources :users, only:[:show,:edit,:update]

  # 退会機能のルーティング
  # 退会確認画面の表示
  get 'users/unsubscribe/' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  # ユーザーの有効ステータスを更新
  patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'
  put 'users/withdraw' => 'users#withdraw'

end
