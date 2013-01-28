class PostsController < ApplicationController
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
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.find_all_by_user_id(params[:user_id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(params[:user_id])
  end
end
