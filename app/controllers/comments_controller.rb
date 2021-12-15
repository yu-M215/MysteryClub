class CommentsController < ApplicationController
  def create
    @mystery = Mystery.find(params[:mystery_id])
    @comment = current_user.comments.new(comment_params)
    @comment.mystery_id = @mystery.id
    @comment.save
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
  end

  def destroy
    @mystery = Mystery.find(params[:mystery_id])
    Comment.find_by(id: params[:id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
