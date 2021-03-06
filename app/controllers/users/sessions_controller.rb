# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :reject_inactive_user, only: [:create]

  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected
  protected

  # 退会済ユーザーのログインを拒否する
  def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])
    return unless @user

    if @user.valid_password?(params[:user][:password]) && !@user.is_actived
      redirect_to new_user_session_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
