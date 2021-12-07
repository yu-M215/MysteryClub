class Comment < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :mystery

  # バリデーション
  validates :comment, presence: true
end
