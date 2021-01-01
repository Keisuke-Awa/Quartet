class UserProfilesController < ApplicationController

  def new
    user = User.find(params[:id])
    @user_profile = user.user_profile
  end

  def update
    
  end

  def show

  end

  private
  
end
