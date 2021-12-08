class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @mysteries = Mystery.where(user_id: @user.id)
  end
end
