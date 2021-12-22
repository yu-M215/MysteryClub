class SearchesController < ApplicationController

  def search
    @keyword = params[:keyword]
    @model = params[:model]
    @mysteries = Mystery.search_for(@keyword).opened.page(params[:page])
    @users = User.search_for(@keyword).page(params[:page])

    # 検索結果が存在しなかった時のメッセージを格納
    if @mysteries.blank?
      @mystery_result = "キーワードを含む謎解きはありません。"
    end

    if @users.blank?
      @user_result = "キーワードを含むユーザーはいません。"
    end
  end
end
