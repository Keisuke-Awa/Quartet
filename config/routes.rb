Rails.application.routes.draw do

  get 'rooms/create'
  get 'rooms/show'
  get 'rooms/index'
  get 'messages/create'
  get 'meetings/new'
  get 'meetings/show'
  get 'meetings/create'
  get 'meetings/destroy'
  get 'meetings/index'
  get 'new/show'
  get 'new/create'
  get 'new/destroy'
  get 'new/index'
  get 'homes/top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  } 

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

end
