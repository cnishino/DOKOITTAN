# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_deleted_user, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

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

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource) #ログイン後の遷移先指定
    mypage_path(@user)
  end

  def after_sign_out_path_for(resource) #ログアウト後の遷移先指定
    root_path
  end

  def guest_sign_in #ゲストログイン機能
    user = User.guest
    sign_in user
    redirect_to user_path(@user)
    flash[:notice] =  "ゲストユーザーでログインしました。"
  end

  def reject_deleted_user #退会済み会員はログインできないように
    @user=User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && @user.is_deleted == true
        flash[:danger] = "お客様は退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。"
        redirect_to newuser_session_path
      end
    end
  end
end
