class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    @mystery = Mystery.find(params[:mystery_id])
    favorite = current_user.favorites.new(mystery_id: @mystery.id)
    favorite.save
  end

  def destroy
    @mystery = Mystery.find(params[:mystery_id])
    favorite = current_user.favorites.find_by(mystery_id: @mystery.id)
    favorite.destroy
  end
end
