class MeetingApplicationsController < ApplicationController

  def create
    @meeting = Meeting.find(params[:meeting_id])
    current_user.apply_meeting(@meeting)
    respond_to do |format|
      format.html { redirect_to @meeting}
      format.js
    end
  end

  def destroy
    @meeting = MeetingApplication.find(params[:id]).meeting
    current_user.unapply_meeting(@meeting)
    respond_to do |format|
      format.html { redirect_to @meeting}
      format.js
    end
  end
end
