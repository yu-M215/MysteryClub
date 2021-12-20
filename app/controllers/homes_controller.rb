class HomesController < ApplicationController
  def top
    @mysteries = Mystery.limit(5).order('created_at DESC')
  end

  def about
  end
end
