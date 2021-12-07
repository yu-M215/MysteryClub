class Mystery < ApplicationRecord

  # アソシエーション
  belongs_to :user
  has_many :favorites, dependent: :destroy

  # バリデーション
  validates :title,:discription,:answer,:answer_discription,:difficulty_level, presence: true

  # 画像アップ用のメソッド
  attachment :image
  attachment :answer_image

  # 引数で渡しているuserがいいねしている投稿か
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
