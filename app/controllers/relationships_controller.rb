class RelationshipsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user

  def create
    current_user.follow(params[:user_id])
  end

  def destroy
    current_user.unfollow(params[:user_id])
  end

  # フォロー一覧
  def followings
  end

  # フォロワー一覧
  def followers
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
