class CommentsController < ApplicationController
  def create
    @mystery = Mystery.find(params[:mystery_id])
    @comment = current_user.comments.new(comment_params)
    @comment.mystery_id = @mystery.id
    @comment.save
    redirect_back fallback_location: mystery_path(@mystery)
  end

  def destroy
    @mystery = Mystery.find(params[:mystery_id])
    @comment = current_user.comments.find_by(mystery_id: @mystery.id)
    @comment.destroy
    redirect_back fallback_location: mystery_path(@mystery)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
