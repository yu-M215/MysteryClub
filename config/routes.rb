Rails.application.routes.draw do
  devise_for :users

  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: 'about'

  resources :mystery
end
