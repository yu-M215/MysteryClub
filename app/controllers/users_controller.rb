class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
    if @user == current_user
      @notifications_count = current_user.passive_notifications.where(checked: false).count
      @mysteries = current_user.mysteries.page(params[:page]).reverse_order
    else
      @mysteries = Mystery.opened.where(user_id: @user.id).page(params[:page]).reverse_order
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites_id = @user.favorites.pluck(:mystery_id)
    @mysteries = Mystery.opened.where(id: favorites_id).page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "プロフィールを更新しました！"
    else
      render 'edit'
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
    params.require(:user).permit(:name, :introduction, :profile_image, :birthday, :is_birthday_opened)
  end

  # 自分以外のユーザーのプロフィール編集画面にアクセスできないようにする
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
      flash[:notice] = "アクセスできません。"
    end
  end
end
