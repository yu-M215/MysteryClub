class Mystery < ApplicationRecord

  # アソシエーション
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  # バリデーション
  validates :title,:discription,:answer,:answer_discription,:difficulty_level, presence: true

  # 画像アップ用のメソッド
  attachment :image
  attachment :answer_image

  # 引数で渡しているuserがいいねしている投稿か
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 検索フォームに入力された文字列をtitleかdiscriptionに含む投稿を探す
  def self.search_for(keyword)
    Mystery.where('title LIKE ?', '%'+keyword+'%').or(Mystery.where('discription LIKE ?', '%'+keyword+'%'))
  end
end
