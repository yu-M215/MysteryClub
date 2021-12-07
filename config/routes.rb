Rails.application.routes.draw do
  get 'comments/create'
  get 'comments/destroy'
  devise_for :users

  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'

  resources :mysteries do
    resource :favorites, only:[:create,:destroy]
  end
end
