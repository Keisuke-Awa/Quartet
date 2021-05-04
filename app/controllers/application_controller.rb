class ApplicationController < ActionController::Base

  include AjaxHelper
  include DatetimeHelper

  # rescue_from StandardError, with: :redirect_to_root

  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger

  before_action :authenticate_user_with_ajax!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?  
  before_action :set_locale

  protected  

  def configure_permitted_parameters
    #deviseのpermitted_parameterを追加する
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(name avatar sex birth_date residence_id phone_number))
    devise_parameter_sanitizer.permit(:account_update, keys: %i(name avatar))
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
 
  def authenticate_user_with_ajax!
    return if user_signed_in?
    respond_to do |format|
      format.html { redirect_to new_user_session_path, alert: "アカウント登録もしくはログインしてください。" }
      format.js { render ajax_redirect_to(new_user_session_path), flash[:alert] = "アカウント登録もしくはログインしてください。" }
    end
  end

  def redirect_to_root
    respond_to do |format|
      format.html { redirect_to root_path, flash: {error: "予期せぬエラーが発生しました。"} }
      format.js { render ajax_redirect_to(root_path), flash[:error] = "予期せぬエラーが発生しました。" }
    end
  end

  def initialize_form_option
    birthplaces = PrefectureMst.all
    occupations = OccupationMst.all
    educational_bgs = EducationalBgMst.all
    annual_incomes = AnnualIncomeMst.all
    smoking_statuses = SmokingMst.all
    @form_option = {birthplaces: birthplaces, occupations: occupations, educational_bgs: educational_bgs, 
      annual_incomes: annual_incomes, smoking_statuses: smoking_statuses}
  end
end