Rails.application.routes.draw do

  root 'homes#top'
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

  resources :meetings do
    collection do
      get :search
    end
  end

  resources :users, only: [:show, :destroy]
  resources :message_rooms, only: [:index, :show, :create]
  resources :messages, only: [:create]
  resources :meetings, only: [:index, :new, :create, :show, :destroy]

  if Rails.env.development?  
    mount LetterOpenerWeb::Engine, at: "/letter_opener"  
  end
end
