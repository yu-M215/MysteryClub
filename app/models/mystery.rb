class Mystery < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
　has_many :notifications, dependent: :destroy

  # バリデーション
  validates :title, :discription, :answer, :answer_discription, :difficulty_level, presence: true

  # 画像アップ用のメソッド
  attachment :image
  attachment :answer_image

  # 引数で渡しているuserがいいねしている投稿か
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 非公開設定の投稿を除く
  def self.opened
    Mystery.where(is_opened: true)
  end

  # 検索フォームに入力された文字列をtitleかdiscriptionに含む投稿を探す
  def self.search_for(keyword)
    Mystery.where('title LIKE ?', "%#{keyword}%").or(Mystery.where('discription LIKE ?', "%#{keyword}%"))
  end

  # 選択された方法で投稿を並べ替える
  def self.sort(method)
    case method
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'favorites'
      return left_joins(:favorites).group(:id).order(Arel.sql('COUNT(favorites.id) desc'))
    when 'difficulty'
      return all.order(difficulty_level: :DESC)
    end
  end
end
