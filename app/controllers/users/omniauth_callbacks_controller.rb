# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]


  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  def facebook
    callback_from :facebook
  end

  def failure
    redirect_to root_url, alert: "認証に失敗しました。"
  end

  protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  def callback_from(provider)
    info = User.find_for_oauth(request.env['omniauth.auth'])
    @user = info[:user]
    if @user.persisted? 
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else 
      sns_credential = info[:sns_credentisal]
      # session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra)
      render template: "users/registrations/new" 
    end
  end


  # def callback_from(provider)
  #   provider = provider.to_s

  #   @user = User.find_for_oauth(request.env['omniauth.auth'])

  #   if @user.persisted?
  #     flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
  #     sign_in_and_redirect @user, event: :authentication
  #   else
  #     session["devise.#{provider}_data"] = request.env['omniauth.auth']
  #     redirect_to new_user_registration_url
  #   end
  # end
end
