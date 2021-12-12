class RoomsController < ApplicationController
  def create
    @room = Room.create
    @my_room = UserRoom.create(room_id: @room.id, user_id: current_user.id)
    @user_room = UserRoom.create(room_id: @room.id, user_id: params[:room][:user_id])

    # @my_room = current_user.user_rooms.create(room_id: @room.id)
    # @user_room = @room.user_room.create(user_id: params[:room][:user_id])
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @chats = Chat.new
      @user_rooms = @room.user_rooms
    else
      redirect_back(fallback_location: user_path(params[:room][:user_id]))
    end
  end
end
