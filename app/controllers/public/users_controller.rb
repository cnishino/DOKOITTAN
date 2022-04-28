class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.where.not(is_deleted: "true").where.not(name: "guestuser").page(params[:page]).per(6)
  end

  def mypage
    @user = current_user
    post_locations = @user.post_locations.where(is_active: "true")
    @post_locations = post_locations.order(created_at: "DESC").page(params[:page]).per(9)
    @favorites = Favorite.where(user_id: current_user.id)
  end

  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_location_id)
    @favorite_posts = PostLocation.find(favorites)
    @favorite_posts = Kaminari.paginate_array(@favorite_posts).page(params[:page]).per(12)
  end

  def show
    @user = User.find(params[:id])
    post_locations = @user.post_locations.where(is_active: "true") #ステータスが投稿のもののみ表示
    @post_locations = post_locations.order(created_at: "DESC").page(params[:page]).per(9)
    @favorites = Favorite.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "マイページを編集しました。"
      redirect_to mypage_path
    else
      flash.now[:alert] = "名前を入力してください。"
      render :edit
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
