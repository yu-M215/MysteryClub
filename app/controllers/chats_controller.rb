class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :follow_each_other, only: [:show]

  def index
    @users = current_user.followings
    @notifications = current_user.passive_notifications.where(checked: false).where(action: 'chat')
  end

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    # ルームがなければ作成
    if user_room.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      @room = user_room.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chats = Chat.where(room_id: params[:chat][:room_id])
    @chat = current_user.chats.new(chat_params)
    @chat.save
    # 通知の作成
    @chat.create_notification_chat(current_user)
  end

  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def follow_each_other
    user = User.find(params[:id])
    # 相互フォローでなければユーザーページに戻る
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to user_path(user)
    end
  end
end
