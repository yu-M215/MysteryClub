class Relationship < ApplicationRecord

  # アソシエーション
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # フォロー一覧
  def followings
     user = User.find(params[:user_id])
     @users = user.followings
  end

  # フォロワー一覧
  def followers
     user = User.find(params[:user_id])
     @users = user.followers
  end
end
