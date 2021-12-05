class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :name, :tellphone_number, :email, :birthday, presence: true
  validates :name, length: { in: 1..10 }
  validates :introduction, length: { maximum: 200 }
  validates :tellphone_number, numericality: :only_integer
end
