class HomesController < ApplicationController
  def top
    @mysteries = Mystery.all
  end

  def about
  end
end
