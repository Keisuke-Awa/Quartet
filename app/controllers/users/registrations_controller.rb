# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticated?, only: [:new]
  before_action :configure_sign_up_params, only: [:create]
  before_action :ensure_normal_user, only: :destroy
  before_action :initialize_form_option, only: [:edit, :update]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @places = Place.all
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params.merge(phone_number: session[:phone_number]))
    ActiveRecord::Base.transaction do
      UserProfile.create!(user_id: resource.id) if resource.save
    end

    yield resource if block_given?
    if resource.persisted?
      session[:phone_number].clear if session[:phone_number].present?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super
    if account_update_params[:avatar].present?
      resource.avatar.attach(account_update_params[:avatar])
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    home_user_path(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    home_user_path(resource)
  end

  def authenticated?
    redirect_to root_path unless session[:auth_code].present?
    session[:auth_code] = nil
  end

  def ensure_normal_user
    if resource.email == 'guest@sample.com'
      redirect_to root_path, alert: '????????????????????????????????????????????????'
    end
  end
end
