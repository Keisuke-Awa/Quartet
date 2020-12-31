class MessageRoomsController < ApplicationController
  before_action :set_room, only: :show
  
  def create
    ActiveRecord::Base.transaction do
      @room = MessageRoom.create!
      @room_user1 = MessageRoomUser.create!(room_id: @room.id, user_id: current_user.id)
      @room_user2 = MessageRoomUser.create!(params.require(:room_user).permit(:user_id, :room_id).merge(room_id: @room.id))
    end
    redirect_to room_path(@room.id)
  rescue => e
    redirect_to root_path
  end

  def show
    if MessageRoomUser.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @room.users.each do |user|
        @user = user unless user == current_user
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @rooms = current_user.message_rooms
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

end
