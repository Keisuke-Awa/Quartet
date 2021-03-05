class MeetingApplicationsController < ApplicationController

  def create
    @meeting = Meeting.find(params[:meeting_id])
    @meeting_application = MeetingApplication.create!(meeting_application_params)
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

  def index
    @meeting = Meeting.find(params[:meeting_id])
    @meeting_applications = @meeting.meeting_applications.eager_load([:applicant])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @meeting = Meeting.find(params[:meeting_id])
    @meeting_application = MeetingApplication.find(params[:id])
    Array(current_user.message_rooms).each do |cmr|
      Array(@appointment.not_current_user(current_user).message_rooms).each do |ncmr|
        @message_room ||= ncmr if cmr == ncmr
      end
    end
  end

  private

  def meeting_application_params
    params.require(:meeting_application).permit(:detail).merge(meeting_id: params[:meeting_id], applicant_id: current_user.id)
  end

end
