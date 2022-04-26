class Public::PostLocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @post_location = PostLocation.find(params[:id])
    # @post_location_comments = PostComment.where(post_location_id: params[:id]).includes(:user).order(created_at: "DESC")
    @post_location_comments = @post_location.post_comments.order(created_at: "DESC").includes(:user)
    @user = @post_location.user
    @post_comment = PostComment.new
  end

  def index
    @users = User.where.not(is_deleted: "true").where.not(name: "guestuser")
    post_locations = PostLocation.where(is_active: "true").where(user_id: @users).page(params[:page]).per(12)
    @post_locations = post_locations.order(created_at: "DESC")
    # @post_locations = PostLocation.all.page(params[:page]).per(6)
  end

  def confirm
    @user = current_user
    @drafts = @user.post_locations.where(is_active: "false")
    @post_locations = @user.post_locations.where(is_active: "false")
    @drafts = Kaminari.paginate_array(@drafts).page(params[:page]).per(12)
  end

  def form
    @post_location = PostLocation.new
  end

  def create
    @post_location = PostLocation.new(post_location_params)
    @post_location.user_id = current_user.id
    if @post_location.save
      if @post_location.is_active == true
        flash[:notice] = "投稿しました。"
        redirect_to post_location_path(@post_location)
      else
        flash[:notice] = "下書きに保存しました。"
        redirect_to confirm_post_locations_path(@post_location)
      end
    else
      @post_locations = PostLocation.all
      flash.now[:alert] = "全ての項目を入力してください。"
      render "public/post_locations/form"
    end
  end

  def edit
    @post_location = PostLocation.find(params[:id])
  end

  def update
    @post_location = PostLocation.find(params[:id])
    if @post_location.update(post_location_params)
      if @post_location.is_active == true
        flash[:notice] = "投稿を編集しました。"
        redirect_to post_location_path(@post_location)
      else
        flash[:notice] = "投稿を下書きに保存しました。"
        redirect_to confirm_post_locations_path(@post_location)
      end
    else
      flash.now[:alert] = "全ての項目を入力してください。"
      render "public/post_locations/form"

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

