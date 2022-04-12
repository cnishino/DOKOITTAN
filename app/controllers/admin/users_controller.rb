class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.where.not(id: "1")
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
      redirect_to admin_users_path
      flash[:notice] = "会員情報を編集しました。"
    else
      render :edit
      flash.now[:alert] = "入力内容に誤りがあります。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_deleted)
  end
end
