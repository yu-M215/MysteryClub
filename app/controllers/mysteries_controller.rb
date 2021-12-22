class MysteriesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_mystery, only:[:show,:edit,:update,:destroy]

  def index
    @mysteries = Mystery.opened.page(params[:page]).reverse_order
  end

  def sort
    method = params[:method]
    @mysteries = Mystery.sort(method).opened.page(params[:page])
    render 'index'
  end

  def show
    if !@mystery.is_opened && @mystery.user != current_user
      redirect_to mysteries_path, notice: "非公開投稿のため、アクセスできません。"
    end
    @comment = Comment.new
  end

  def new
    @mystery = Mystery.new
  end

  def create
    @mystery = Mystery.new(mystery_params)
    @mystery.user_id = current_user.id

    if @mystery.save
      redirect_to mystery_path(@mystery.id)
      flash[:notice] = "新しい謎解きを投稿しました！"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @mystery.update(mystery_params)
      redirect_to mystery_path(@mystery)
      flash[:notice] = "更新しました！"
    else
      render 'edit'
    end
  end

  def destroy
    if @mystery.destroy
      redirect_to mysteries_path
      flash[:notice] = "投稿を削除しました。"
    else
      @comment = Comment.new
      render 'show'
    end
  end

  private

  def mystery_params
    params.require(:mystery).permit(:title,:discription,:image,:answer,:answer_image,:answer_discription,:difficulty_level,:is_opened)
  end

  def set_mystery
    @mystery = Mystery.find(params[:id])
  end

end
