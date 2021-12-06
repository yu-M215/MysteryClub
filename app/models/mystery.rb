class Mystery < ApplicationRecord

  # アソシエーション
  belongs_to :user

  # バリデーション
  validates :title,:discription,:answer,:answer_discription, presence: true

  # 画像アップ用のメソッド
  attachment :image, :answer_image

end
