class PostsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @post = Post.create(params[:post])
    @post.user_id = params[:user_id]
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
    @user_who_commented = User.find(@post.user_id)
    @nested_comment_list = Post.nested_comment(@post)
    @comment = Comment.new
  end

  def index
    @posts = Post.get_ordered_comments(params[:page])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(params[:user_id])
  end
end
