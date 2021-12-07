Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  devise_for :users

  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'

  resources :mysteries
end
