class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mystery
  before_action :ensure_correct_user, only: %i[update destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.mystery_id = @mystery.id
    @comment.save
  end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private

  def set_mystery
    @mystery = Mystery.find(params[:mystery_id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end

  # 自分以外のユーザーの投稿は編集削除できないようにする
  def ensure_correct_user
    @comment = Comment.find(params[:id])
    @user = @comment.user
    unless @user == current_user
      redirect_to mystery_path(@mystery)
      flash[:notice] = "アクセスできません。"
    end
  end
end
