class SearchesController < ApplicationController

  def search
    @keyword = params[:keyword]
    @model = params[:model]
    @mysteries = Mystery.search_for(@keyword)
    @users = User.search_for(@keyword)

    # 検索結果が存在しなかった時のメッセージを格納
    if @mysteries.blank?
      @mystery_result = "キーワードを含む謎解きはありません。"
    end

    if @users.blank?
      @user_result = "キーワードを含むユーザーはいません。"
    end
  end
end
