class HomesController < ApplicationController
  def top
    mystery_id = Mystery.left_joins(:favorites).group(:id).order(Arel.sql('COUNT(favorites.id) desc')).limit(3).pluck(:id)
    @first_mystery = Mystery.find(mystery_id[0])
    @second_mystery = Mystery.find(mystery_id[1])
    @third_mystery = Mystery.find(mystery_id[2])
  end

  def about
  end
end
