class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.where.not(is_deleted: "t").where.not(id: "1")
  end

  def mypage
    @user = current_user
    @post_locations = @user.post_locations.all
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
      redirect_to mypage_path
      flash[:notice] = "マイページを編集しました。"
    else
      render :edit
      flash.now[:alert] = "入力内容に誤りがあります。"
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
    flash[:notice] = "退会しました。またのご利用をお待ちしております。"
  end

  private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user)
      flash[:notice] = 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
