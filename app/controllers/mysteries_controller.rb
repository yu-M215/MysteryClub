class MysteriesController < ApplicationController

  before_action :set_mystery, only:[:show,:edit,:update,:destroy]

  def index
    @mysteries = Mystery.all
  end

  def show
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
      render "new"
    end
  end

  def edit
  end

  def update
    if @mystery.update(mystery_params)
      redirect_to mystery_path(@mystery)
    else
      render "edit"
      flash[:notice] = "更新処理に失敗しました。"
    end
  end

  def destroy
    @mystery.destroy
  end

  private

  def mystery_params
    params.require(:mystery).permit(:title,:discription,:image,:answer,:answer_image,:answer_discription,:difficulty_level,:is_opened)
  end

  def set_mystery
    @mystery = Mystery.find(params[:id])
  end

end
