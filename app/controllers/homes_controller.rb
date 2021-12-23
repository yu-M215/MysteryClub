class HomesController < ApplicationController
  def top
    mystery_id = Mystery.opened.left_joins(:favorites).group(:id).order(Arel.sql('COUNT(favorites.id) desc')).limit(3).pluck(:id)
    if mystery_id.count < 3
      @mysteries = Mystery.opened
      return
    else
      @first_mystery = Mystery.find(mystery_id[0])
      @second_mystery = Mystery.find(mystery_id[1])
      @third_mystery = Mystery.find(mystery_id[2])
    end
  end

  def about; end
end
