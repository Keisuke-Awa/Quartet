class AppointmentsController < ApplicationController
  def create
    applicant = User.find(params[:applicant_id])
    @meeting = Meeting.find(params[:appointment][:meeting_id])
    ActiveRecord::Base.transaction do
      @appointment = Appointment.create!(meeting_id: @meeting.id)
      current_user.make_appointment(@appointment, applicant)
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
  end
end
