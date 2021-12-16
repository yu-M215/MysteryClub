class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    if @user == current_user
      @mysteries = current_user.mysteries
    else
      @mysteries = Mystery.where(user_id: @user.id).where(is_opened: true)
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

  # 自分以外のユーザーのプロフィール編集画面にアクセスできないようにする
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
