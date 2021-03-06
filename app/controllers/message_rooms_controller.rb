class MessageRoomsController < ApplicationController

  before_action :set_room, only: :show
  
  def create
    user = User.find(params[:user_id])
    ActiveRecord::Base.transaction do
      @message_room = MessageRoom.create!
      MessageRoomUser.create!(message_room_id: @message_room.id, user_id: current_user.id)
      @room_user = MessageRoomUser.create!(message_room_id: @message_room.id, user_id: user.id)
    end
    redirect_to message_room_path(@message_room.id)
  end

  def show
    if MessageRoomUser.where(user_id: current_user.id, message_room_id: @message_room.id).present?
      @messages = @message_room.messages.includes(:user)
      @message_partner = @message_room.users.select_partner(current_user)
      respond_to do |format|
        format.html
        format.js
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @message_rooms = current_user.message_rooms
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_room
    @message_room = MessageRoom.find(params[:id])
  end

end
