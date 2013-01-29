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
      logger.info("-------------#{@post.errors.inspect}")
      redirect_to :back

    end
  end

  def show
    @post = Post.find(params[:id])
    @user_who_commented = current_user
    #@all_comments = @Post.comment_threads
    #@comment = Comment.new
    #logger.info("############{@all_comments.inspect}")
  end

  def index
    @posts = Post.order("created_at DESC").all.paginate(:page => params[:page], :per_page => 5);
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path(params[:user_id])
  end
end
