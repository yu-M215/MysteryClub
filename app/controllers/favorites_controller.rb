class FavoritesController < ApplicationController
  def create
    mystery = Mystery.find(params[:mystery_id])
    favorite = current_user.favorites.new(mystery_id: mystery.id)
    favorite.save
    redirect_back fallback_location: mystery_path(mystery)
  end

  def destroy
    mystery = Mystery.find(params[:mystery_id])
    favorite = current_user.favorites.find_by(mystery_id: mystery.id)
    favorite.destroy
    redirect_back fallback_location: mystery_path(mystery)
  end
end
