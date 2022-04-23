class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post_location = PostLocation.find(params[:post_location_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_location_id = post_location.id

    if comment.save
      @post_comment = comment
      @post_location = PostLocation.find(params[:post_location_id])
      flash.now[:notice] = ""
    else
      @post_comment = comment
      @post_location = PostLocation.find(params[:post_location_id])
      flash.now[:alert] = "コメントを入力してください。"
      render :create
    end
  end

  def destroy
    PostComment.find_by(id: params[:id], post_location_id: params[:post_location_id]).destroy
    @post_location = PostLocation.find(params[:post_location_id])
  end



  private
  def post_comment_params
    params.require(:post_comment).permit(:comment,:post_location_id,:user_id)
  end
end
