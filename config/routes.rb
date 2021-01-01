Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope "(:locale)", locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do

    root 'homes#top'

    devise_for :users, skip: :omniauth_callbacks, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions',
    } 

    resources :users, only: [:show, :destroy] do
      member do
        get :home
        get :index_meeting
        get :index_appointment
        get :show_mypage
      end

      resource :user_profile, only: %i(new edit update show)
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

  end

  devise_for :users, only: :omniauth_callbacks, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get '/:locale' => 'homes#top'
  # match 'users/auth/failure' => 'users/omniauth_callbacks#failure', via: [:get, :post]

  if Rails.env.development?  
    mount LetterOpenerWeb::Engine, at: "/letter_opener"  
  end
end
