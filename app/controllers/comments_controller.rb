class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @user_who_commented = current_user
    @comment = Comment.build_from( @post, @user_who_commented.id, params[:comment][:body])
    if @comment.save
      flash[:success] = "commented successfully!"
      redirect_to user_post_path(current_user,@post)
    else
      flash[:error] = "comment failed!"
      redirect_to :back
    end
  end
end
