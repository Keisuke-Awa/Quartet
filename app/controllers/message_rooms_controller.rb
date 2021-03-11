class MessageRoomsController < ApplicationController

  before_action :set_room, only: :show
  
  def create
    user = User.find(params[:user_id])
    @message_room = MessageRoom.choice_by_discarded(MessageRoomUser.select_by(current_user), MessageRoomUser.select_by(user))
    if @message_room.present?
      @message_room.undiscard
    else
      ActiveRecord::Base.transaction do
        @message_room = MessageRoom.create!
        MessageRoomUser.create!(message_room_id: @message_room.id, user_id: current_user.id)
        @room_user = MessageRoomUser.create!(message_room_id: @message_room.id, user_id: user.id)
      end
    end
    respond_to do |format|
      format.html { redirect_to message_room_path(@message_room.id) }
      format.js { render ajax_redirect_to(message_room_path(@message_room.id)) }
    end
  end

  def show
    if MessageRoom.find(@message_room.id).present?
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
