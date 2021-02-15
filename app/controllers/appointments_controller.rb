class AppointmentsController < ApplicationController
  def create
    applicant = User.find(params[:applicant_id])
    @meeting = Meeting.find(params[:appointment][:meeting_id])
    ActiveRecord::Base.transaction do
      @appointment = Appointment.create!(meeting_id: @meeting.id)
      current_user.make_appointment(@appointment, applicant)
      @meeting.update!( appointment_id: @appointment.id )
      @meeting.meeting_applications.delete_all
    end
    respond_to do |format|
      format.html { redirect_to index_appointment_user_path(current_user) }
      format.js
    end
  end

  def destroy
  end

  def show
    @appointment = Appointment.find(params[:id])
    Array(current_user.message_rooms).each do |cmr|
      Array(@appointment.not_current_user(current_user).message_rooms).each do |ncmr|
        @message_room ||= ncmr if cmr == ncmr
      end
    end
  end

  def index
  end
end
