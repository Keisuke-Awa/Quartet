class AppointmentsController < ApplicationController

  def create
    applicant = User.find(params[:applicant_id])
    @meeting = Meeting.find(params[:appointment][:meeting_id])
    ActiveRecord::Base.transaction do
      @appointment = Appointment.create!(meeting_id: @meeting.id)
      current_user.make_appointment(@appointment, applicant)
      @meeting.update!( appointment_id: @appointment.id )
      @meeting.meeting_applications.delete_all
      if MessageRoom.delete_by_appointment?(current_user, applicant)
        current_user.message_rooms.each do |cmr|
          applicant.message_rooms.each { |amr| break is_break = true if cmr == amr }
          break cmr.delete! if is_break
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to index_appointment_user_path(current_user), notice: "マッチングが成立しました。" }
      format.js { render ajax_redirect_to(index_appointment_user_path(current_user)), flash[:notice] = "マッチングが成立しました。" }
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
