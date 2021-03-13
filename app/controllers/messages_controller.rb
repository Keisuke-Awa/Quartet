class MessagesController < ApplicationController

  def index
    @message_room = MessageRoom.find(params[:message_room_id])
    @messages = @message_room.messages.includes(:user).where('id > ?', params[:last_id])
    respond_to do |format|
      format.json
    end
  end
  
  def create
    # if MessageRoomUser.where(user_id: current_user.id, message_room_id: params[:message_room_id]).present?
    message_room = MessageRoom.find(params[:message_room_id])
    receiver = message_room.users.where.not(id: current_user.id)
    ActiveRecord::Base.transaction do
      @message = Message.create!(message_params)
      NewArrival.create!(user: receiver, model: "Message", record_id: @message.id)
    end
      if @message
        respond_to do |format|
          format.html { redirect_to message_room_path(@message.message_room_id) }
          format.json
        end
      else
        redirect_to message_room_path(@message.room_id)
      end
    # else
    #   redirect_back(fallback_location: root_path)
    # end
  end

  private

  def message_params
    params.require(:message).permit(:message_room_id, :content).merge(user_id: current_user.id)
  end
end
