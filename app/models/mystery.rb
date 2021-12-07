class Mystery < ApplicationRecord

  # アソシエーション
  belongs_to :user
  has_many :favorites, dependent: :destroy

  # バリデーション
  validates :title,:discription,:answer,:answer_discription,:difficulty_level, presence: true

  # 画像アップ用のメソッド
  attachment :image
  attachment :answer_image

end
