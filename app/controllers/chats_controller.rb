class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    room = Room.find(params[:room_id])
    @message = current_user.chats.new(chat_params)
    @message.room_id = room.id
    if @message.save
      redirect_to room_path(room)
    else
      redirect_back(fallback_location: room_path(room))
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message)
  end
end
