class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :misteries, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :relationships, class_name: "Relationships", foreign_key: "follower_id", dependent: :destroy
  has_many :follwings, through: :relationships, source: :followed
  has_many :reverse_relationships, class_name: "Relationshiop", foreign_key: "follwed_id", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  # バリデーション
  validates :name, :tellphone_number, :email, :birthday, presence: true
  validates :name, length: { in: 1..10 }
  validates :introduction, length: { maximum: 200 }
  validates :tellphone_number, numericality: :only_integer

  # 画像アップ用のメソッド
  attachment :profile_image
end
