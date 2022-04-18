class Public::PostLocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @post_location = PostLocation.find(params[:id])
    @user = @post_location.user
    @post_comment = PostComment.new
  end

  def index
    @users = User.where.not(is_deleted: "true").where.not(name: "guestuser")
    @post_locations = PostLocation.where(is_active: "true").where(user_id: @users).page(params[:page]).per(8)
  end

  def confirm
    @user = current_user
    @drafts = @user.post_locations.where(is_active: "false")
  end


  def form
    @post_location = PostLocation.new
  end

  def create
    @post_location = PostLocation.new(post_location_params)
    @post_location.user_id = current_user.id
    if @post_location.save
      redirect_to post_location_path(@post_location)
      flash[:notice] = "投稿しました。"
    else
      @post_locations = PostLocation.all
      render "form"
      flash[:alert] = "全ての項目を入力してください。"
    end
  end

  def edit
    @post_location = PostLocation.find(params[:id])
  end

  def update
    @post_location = PostLocation.find(params[:id])
    if @post_location.update(post_location_params)
      redirect_to post_location_path(@post_location)
      flash[:notice] = "投稿を編集しました。"
    else
      render "edit"
      flash[:alert] = "全ての項目を入力してください。"
    end
  end

  def destroy
    @post_location = PostLocation.find(params[:id])
    @post_location.destroy
    redirect_to post_locations_path(@post_locations)
    flash[:alert] = "投稿を削除しました。"
  end

  private

  def post_location_params
    params.require(:post_location).permit(:user_id, :genre_id, :prefecture, :facility_name, :target_age_id, :introduction, :post_image, :is_active)
  end

  def ensure_correct_user
    @post_location = PostLocation.find(params[:id])
    unless @post_location.user == current_user
      redirect_to post_locations_path
    end
  end
end

