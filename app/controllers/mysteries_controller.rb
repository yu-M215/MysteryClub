class MysteriesController < ApplicationController

  def index
    @mysteries = Mystery.all
  end

  def show
    @mystery = Mystery.find(params[:id])
  end

  def new
    @mystery = Mystery.new
  end

  def create
    @mystery = Mystery.new(mystery_params)
    @mystery.user_id = current_user.id
    if @mystery.save
      redirect_to mystery_path(@mystery.id)
    else
      render index
    end
  end

  def edit
    @mystery = Mystery.find(params[:id])
  end

  def update
    @mystery = Mystery.find(params[:id])
    if @mystery.update(mystery_params)
      redirect_to mystery_path(@mystery)
    else
      render edit
      flash[:notice] = "更新処理に失敗しました。"
    end
  end

  def destroy
  end

  private

  def mystery_params
    params.require(:mystery).permit(:title,:discription,:image,:answer,:answer_image,:answer_discription,:difficulty_level,:is_opened)
  end

end
