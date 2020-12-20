Rails.application.routes.draw do

  root 'homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  } 

  resources :users, only: [:show, :destroy] do
    member do
      get :home
      get :index_meeting
      get :index_appointment
      get :show_mypage
    end
  end



  resources :meetings, only: [:index, :new, :create, :show, :destroy] do
    get :search, on: :collection
    #get :index_meeting_application, on: :member
    resources :meeting_applications, only: [:create, :destroy, :index, :show]
  end

  resources :message_rooms, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end

  resources :appointments, only: [:create, :destroy, :show, :index]
  
  post 'sms_identifications/send_code'
  post 'sms_identifications/check_code'
  get 'sms_identifications/input_code'

  if Rails.env.development?  
    mount LetterOpenerWeb::Engine, at: "/letter_opener"  
  end
end
