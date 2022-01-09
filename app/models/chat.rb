class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  validates :message, presence: true

  # DMの通知
  def create_notification_message(current_user)
    # room = Room.find(room_id)
    user_room = UserRoom.find(room_id: room_id)
    user = User.where(id: user_room.user_id).where.not(id: current_user.id)
    notification = current_user.active_notifications.new(
      visited_id: user.id,
      chat_id: self.id,
      action: 'chat'
    )
    notification.save if notification.valid?
  end
end
