class Public::FavoritesController < ApplicationController

  def create
    post_location = PostLocation.find(params[:post_location_id])
    favorite = current_user.favorites.new(post_location_id:post_location.id)
    favorite.save
    @post_location = post_location
    # redirect_to request.referer
  end

  def destroy
    post_location = PostLocation.find(params[:post_location_id])
    favorite = current_user.favorites.new(post_location_id:post_location.id)
    favorite.save
    @post_location = post_location
    # redirect_to request.referer
  end

end
