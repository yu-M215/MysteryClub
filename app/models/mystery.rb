class Mystery < ApplicationRecord

  # アソシエーション
  belongs_to :user

  # バリデーション
  validates :title,:discription,:answer,:answer_discription,:difficulty_level, presence: true

  # 画像アップ用のメソッド
  attachment :image
  attachment :answer_image

end
