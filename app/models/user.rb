class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :misteries, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  # バリデーション
  validates :name, :tellphone_number, :email, :birthday, presence: true
  validates :name, length: { in: 1..10 }
  validates :introduction, length: { maximum: 200 }
  validates :tellphone_number, numericality: :only_integer
end
