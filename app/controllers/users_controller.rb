class UsersController < ApplicationController
  
  before_action :correct_user, only: [:destroy]
  before_action :set_user, only: [:home, :destroy, :show]
  before_action :restrict_by_sex, only: :show
  
  def home
  end
  
  def show
    @current_user_room = MessageRoomUser.where(user_id: current_user.id)
    @other_user_room = MessageRoomUser.where(user_id: @user.id)
  
    unless current_user.id == @user.id
      @current_user_room.each do |cur|
        @other_user_room.each do |our|
          if cur.room_id == our.room_id
            @is_room = true
            @room_id = cur.room_id
          end
        end
      end
      unless @is_room
        @room = MessageRoom.new
        @room_user = MessageRoomUser.new
      end
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = 'ユーザーを削除しました。'
    redirect_to root_url
  end

  def index_meeting
    delete_new_arrivals("MeetingApplication")
    @meetings = current_user.meetings.where(appointment_id: nil).page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index_appointment
    delete_new_arrivals("Appointment")
    @appointments = current_user.appointments.includes(:meeting)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index_message_room
    delete_new_arrivals("Message")
    @message_rooms = current_user.message_rooms.select { |mr| mr.messages.where(user_id: current_user.id) }
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index_meeting_application
    meetings = current_user.meeting_applications.with_meeting_all.map(&:meeting)
    @meetings = Kaminari.paginate_array(meetings).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to root_path
    end
  end

  def restrict_by_sex
    return unless @user.sex == current_user.sex
    respond_to do |format|
      format.html { redirect_to home_user_path(current_user), flash: {error: "該当ページにはアクセスできません。"} }
      format.js { render ajax_redirect_to(home_user_path(current_user)), flash[:error] = "該当ページにはアクセスできません。" }
    end
  end

  def delete_new_arrivals(content)
    current_user.new_arrivals.select_model(content).delete_all
  end
  
end