class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @user_who_commented = params[:user_id]

    #@comment = Comment.build_from( @post, @user_who_commented.id, params[:comment][:body])
    if @post.comments.create(:comment => params[:comment][:comment], :user_id => params[:user_id], :parent_id => params[:parent_id] )
      flash[:success] = "commented successfully!"
      redirect_to user_post_path(current_user,@post)
    else
      flash[:error] = "comment failed!"
      redirect_to :back
    end
  end
end
