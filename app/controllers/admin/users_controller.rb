class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(12).where.not(name: "guestuser")#ゲストユーザー以外表示
  end

  def show
    @user = User.find(params[:id])
    @post_locations = @user.post_locations.where(is_active: "true")#ステータスが投稿のもののみ表示
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報を編集しました。"
      redirect_to admin_users_path
    else
      flash.now[:alert] = "名前を入力してください。"
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_deleted)
  end
end
