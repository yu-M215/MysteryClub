class HomesController < ApplicationController
  def top
    @mysteries = Mystery.limit(3).order('created_at DESC')
  end

  def about
  end
end
