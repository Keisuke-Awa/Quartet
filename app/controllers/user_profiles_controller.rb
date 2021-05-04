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
    if current_user.user_profile.update!(user_profile_params)
      redirect_to root_path, notice: 'プロフィールを更新しました。'
    else
      redirect_to edit_user_registration_path, error: 'プロフィール更新に失敗しました。'
    end
  end

  def show
    
  end

  private

  def user_profile_params
    params.require(:user_profile).permit(:height, :weight, :blood_type, :birthplace_id, :occupation_id,
      :educational_bg_id, :annual_income_id, :smoking_status_id)
  end
  
end
