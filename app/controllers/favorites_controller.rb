class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @mystery = Mystery.find(params[:mystery_id])
    favorite = current_user.favorites.new(mystery_id: @mystery.id)
    favorite.save
    # いいねしたユーザーと投稿者が一致していなければ通知を作成
    unless @mystery.user_id == current_user.id
      @mystery.create_notification_favorite(current_user)
    end
  end

  def destroy
    @mystery = Mystery.find(params[:mystery_id])
    favorite = current_user.favorites.find_by(mystery_id: @mystery.id)
    favorite.destroy
  end
end
