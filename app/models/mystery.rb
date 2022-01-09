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

  # 新着いいねの通知
  def create_notification_favorite(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and mystery_id = ? and action = ? ", current_user.id, self.user_id, self.id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        mystery_id: self.id,
        visited_id: self.user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      # if notification.visitor_id == notification.visited_id
      #   notification.checked = true
      # end
      notification.save if notification.valid?
    end
  end

  # 新着コメントの通知
  def create_notification_comment(current_user, comment_id)
    notification = current_user.active_notifications.new(
      mystery_id: self.id,
      comment_id: comment_id,
      visited_id: self.user_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    # if notification.visitor_id == notification.visited_id
    #   notification.checked = true
    # end
    notification.save if notification.valid?
  end

end
