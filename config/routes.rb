Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'

  resources :mysteries do
    resources :comments, only:[:create,:destroy]
    resource :favorites, only:[:create,:destroy]
  end
end
