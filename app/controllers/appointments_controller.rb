class AppointmentsController < ApplicationController

  def create
    matching_partner = User.find(params[:applicant_id])
    @meeting = Meeting.find(params[:appointment][:meeting_id])
    meeting_applications = @meeting.meeting_applications.eager_load(:applicant)
    applicants = meeting_applications.map(&:applicant)
    ActiveRecord::Base.transaction do
      @appointment = Appointment.create!(meeting_id: @meeting.id)
      current_user.make_appointment(@appointment, matching_partner)
      @meeting.update!( appointment_id: @appointment.id )
      @meeting.meeting_applications.delete_all
      applicants.each do |applicant|
        if MessageRoom.delete_by_appointment?(current_user, applicant)
          message_room = MessageRoom.choice_by(MessageRoomUser.select_by(current_user),
                  MessageRoomUser.select_by(applicant)).first
          message_room.discard unless message_room.nil?
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
