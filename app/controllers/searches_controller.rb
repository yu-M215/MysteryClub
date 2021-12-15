class SearchesController < ApplicationController

  def search
    @keyword = params[:keyword]
    @mysteries = Mystery.search_for(@keyword)
    @users = User.search_for(@keyword)
  end
end
