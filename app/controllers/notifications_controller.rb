class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.all.page(params[:page]).per(10)
    # 通知一覧を開いたらcheckedをtrueに更新して確認済みにする
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
