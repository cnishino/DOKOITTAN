class Admin::PostLocationsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @post_locations = PostLocation.where(is_active: "true").page(params[:page]).per(8)
  end

  def show
    @post_location = PostLocation.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post_location = PostLocation.find(params[:id])
  end

  def update
    @post_location = PostLocation.find(params[:id])
    if @post_location.update(post_location_params)
      redirect_to admin_post_locations_path(@post_location)
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
    params.permit(:user_id, :genre_id, :prefecture, :facility_name, :target_age_id, :introduction, :is_active)
  end
end
