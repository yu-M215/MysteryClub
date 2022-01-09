class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :mysteries, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  # フォロー機能
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy

  # 通知が送られる側
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # 通知を送る側
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # バリデーション
  validates :name, :tellphone_number, :email, :birthday, presence: true
  validates :name, length: { in: 1..10 }
  validates :introduction, length: { maximum: 200 }
  validates :tellphone_number, numericality: :only_integer

  # 画像アップ用のメソッド
  attachment :profile_image

  # フォロー機能用
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォロー解除用
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # 引数で渡したユーザーをフォローしているか
  def following?(user)
    followings.include?(user)
  end

  # フォローの通知
  def create_notification_follow(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, self.id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: self.id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # 検索フォームに入力された文字列をnameに含むユーザーを探す
  def self.search_for(keyword)
    User.where('name LIKE ?', "%#{keyword}%")
  end
end
