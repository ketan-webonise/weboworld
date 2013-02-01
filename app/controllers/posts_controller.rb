class PostsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @post = User.find(params[:user_id]).posts.new
  end

  def create
    user = User.find(params[:user_id])
    @post = user.posts.create(params[:post])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to user_post_path(params[:user_id], @post.id)
    else
      flash[:error] = "Post failed!"
      redirect_to :back

    end
  end

  def show
    @post = Post.find(params[:id])
    @nested_comment_list = @post.nested_comment
    @comment = Comment.new
  end

  def index
    @posts = Post.get_ordered_comments(params[:page])
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to user_posts_path(params[:user_id])
  end
end
