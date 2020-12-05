class UsersController < ApplicationController
  before_action :correct_user, only: [:destroy]
  before_action :set_user, only: [:home, :show, :destroy]
  
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
  
    # def index_friend_request
    #   @requested_users = @user.requested_users.eager_load([:avatar_attachment]).page(params[:page])
    #   respond_to do |format|
    #     format.html
    #     format.js
    #   end
    # end
  
    # def index_friend
    #   @friends = @user.friends.eager_load([:avatar_attachment]).page(params[:page])
    #   respond_to do |format|
    #     format.html
    #     format.js
    #   end
    # end
  
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
  
end