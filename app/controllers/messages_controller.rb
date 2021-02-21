class MessagesController < ApplicationController
  def create
    # if MessageRoomUser.where(user_id: current_user.id, message_room_id: params[:message_room_id]).present?
      if @message = Message.create!(message_params)
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
