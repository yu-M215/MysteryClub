class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user, only:[:show,:edit,:update]

  def show
    @mysteries = Mystery.where(user_id: @user.id)

    # DM機能(ルームがあればidを取得、なければ新規ルーム作成)
    unless @user.id == current_user.id
      @user_rooms=UserRoom.where(user_id: @user.id)
      @my_rooms=UserRoom.where(user_id: current_user.id)
      @my_rooms.each do |my_room|
        @user_rooms.each do |user_room|
          if my_room.room_id == user_room.room_id then
            @is_room = true
            @room_id = my_room.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @user_room = UserRoom.new
      end
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
      flash[:notice] = "プロフィールの更新に失敗しました"
    end
  end

  # 退会画面を表示する
  def unsubscribe
    @user = current_user
  end

  # ユーザーの有効ステータスをfalseに更新(論理削除)
  def withdraw
    @user = current_user
    @user.update(is_actived: false)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image,:birthday,:is_birthday_opened)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
