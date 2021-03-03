class HomesController < ApplicationController
  
  skip_before_action :authenticate_user, only: [:top]

  def top
    if user_signed_in?
      redirect_to home_user_path(current_user.id) and return
    end
    render layout: 'top'
  end
end
