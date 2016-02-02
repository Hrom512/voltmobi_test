Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  get 'profile', to: 'tasks#index'
  resources :tasks, :except => :index do
    member do
      post 'start'
      post 'finish'
    end
  end
end
