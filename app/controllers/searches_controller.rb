class SearchesController < ApplicationController

  def search
    keyword = params[:keyword]
    @mysteries = Mystery.search_for(keyword)
    @user = Mystery.search_for(keyword)
  end
end
