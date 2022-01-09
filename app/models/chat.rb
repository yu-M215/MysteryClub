class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  validates :message, presence: true

  # DMの通知
  def create_notification_chat(current_user)
    user_id = UserRoom.where(room_id: room_id).where.not(user_id: current_user.id).pluck(:user_id)
    notification = current_user.active_notifications.new(
      visited_id: user_id[0],
      chat_id: self.id,
      action: 'chat'
    )
    notification.save if notification.valid?
  end
end
