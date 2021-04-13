class UserProfilesController < ApplicationController

  before_action :initialize_form_option, only: %i(new edit)  

  def new
    @user_profile = current_user.user_profile
  end

  def edit
    @user = User.find(params[:user_id])
    @user_profile = @user.user_profile
  end
  

  def update
    current_user.user_profile.update!(user_profile_params)
    redirect_to home_user_path(current_user.id)
  end

  def show
    
  end

  private

  def user_profile_params
    params.require(:user_profile).permit(:height, :weight, :blood_type, :birthplace_id, :occupation_id,
      :educational_bg_id, :annual_income_id, :smoking_status_id)
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
