class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.all.page(params[:page]).per(10)
  end
end
