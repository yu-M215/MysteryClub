class CommentsController < ApplicationController

  before_action :set_mystery

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.mystery_id = @mystery.id
    @comment.save
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_back fallback_location: mystery_path(params[:mystery_id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def set_mystery
    @mystery = Mystery.find(params[:mystery_id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
