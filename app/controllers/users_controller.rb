class UsersController < ApplicationController

  before_action :set_user

  def show
    @mysteries = Mystery.where(user_id: @user.id)
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
    @user = User.find(current_user.id)
  end

　# ユーザーの有効ステータスをfalseに更新(論理削除)
  def withdraw
    @user = User.find(current_user.id)
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
