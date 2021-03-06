class AppointmentsController < ApplicationController

  def create
    applicant = User.find(params[:applicant_id])
    @meeting = Meeting.find(params[:appointment][:meeting_id])
    current_user.message_rooms.each do 
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
    @partner = @appointment.users.select_partner(current_user)
    Array(current_user.message_rooms).each do |cmr|
      Array(@partner.message_rooms).each do |ncmr|
        @message_room ||= ncmr if cmr == ncmr
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
  end
end
