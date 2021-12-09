class Relationship < ApplicationRecord

  # アソシエーション
  belongs_to :follower, class_name: "User"
  belongs_to :following, class_name: "User"
end
