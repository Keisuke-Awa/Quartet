Rails.application.routes.draw do

  root 'homes#top'

  get 'rooms/create'
  get 'rooms/show'
  get 'rooms/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  } 

  resources :users do
    member do
      get :index_friend_request
      get :index_friend
      get :home
    end
  end

  resources :users, only: [:show, :destroy]
  resources :meetings, only: [:index, :new, :create, :show, :destroy]
  resources :messages, only: [:create]

  if Rails.env.development?  
    mount LetterOpenerWeb::Engine, at: "/letter_opener"  
  end
end
