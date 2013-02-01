class CommentsController < ApplicationController
  before_filter :authenticate_user! , :only => [:create]

  def create
    post = Post.find(params[:post_id])
    if post.create_comment(params[:comment][:comment],params[:user_id],params[:parent_id])
      flash[:success] = "commented successfully!"
      redirect_to user_post_path(current_user,post)
    else
      flash[:error] = "comment failed!"
      redirect_to :back
    end
  end
end
