class Public::PostCommentsController < ApplicationController
  
  def create
    post_location = PostLocation.find(params[:post_location_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_location_id = post_location.id
    if comment.save
      @post_comment = comment
      @post_location = PostLocation.find(params[:post_location_id])
    else
      @post_comment = comment
      render :error
    end
    # redirect_to request.referer
  end

  def destroy
    PostComment.find_by(id: params[:id], post_location_id: params[:post_location_id]).destroy
    @post_location = PostLocation.find(params[:post_location_id])
  # redirect_to request.referer
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
