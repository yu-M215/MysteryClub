class Notification < ApplicationRecord
  #新着通知からデータを取得
  default_scope -> { order(created_at: :desc) }

  # アソシエーション
  belongs_to :mystery, optional: true
  belongs_to :comment, optional: true
  belongs_to :chat, optional: true
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
