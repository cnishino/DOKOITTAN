class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post_location = PostLocation.find(params[:post_location_id])
    @favorite = current_user.favorites.new(post_location_id:@post_location.id)
    @favorite.save
    # redirect_to request.referer
  end

  def destroy
    @post_location = PostLocation.find(params[:post_location_id])
    @favorite = current_user.favorites.find_by(post_location_id:@post_location.id)
    @favorite.destroy
    # redirect_to request.referer
  end

end
