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
  end

  def update
  end

  def destroy
  end

  private

  def mystery_params
    params.require(:mystery).permit(:title,:discription,:image,:answer,:answer_image,:answer_discription,:difficulty_level,:is_opened)
  end

end
