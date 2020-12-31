class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?  
  before_action :set_locale

  protected  

  def configure_permitted_parameters
    #deviseのpermitted_parameterを追加する
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(name avatar sex birth_date residence_id))
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar] )
  end

  def after_sign_in_path_for(resource)
    home_user_path(resource.id)
  end

  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  # def default_url_options(options = {})
  #   { locale: I18n.locale }.merge options
  # end

  def set_locale
    I18n.locale = locale
  end

  def locale
    @locale ||= params[:locale] ||= I18n.default_locale
  end

  def default_url_options(options={})
    options.merge(locale: locale)
  end
  
end