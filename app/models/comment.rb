class Comment < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :mystery
  has_many :notifications, dependent: :destroy

  # バリデーション
  validates :comment, presence: true
end
