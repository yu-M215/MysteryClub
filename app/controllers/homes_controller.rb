class HomesController < ApplicationController
  def top
    mystery_id = Mystery.favorite_ranking
    if mystery_id.count < 3
      @mysteries = Mystery.opened
    else
      @first_mystery = Mystery.find(mystery_id[0])
      @second_mystery = Mystery.find(mystery_id[1])
      @third_mystery = Mystery.find(mystery_id[2])
      @first_favorite = @first_mystery.favorites.count
      @second_favorite = @second_mystery.favorites.count
    end
  end

  def about; end
end
