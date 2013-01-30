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
      redirect_to :back

    end
  end

  def show
    @post = Post.find(params[:id])
    @user_who_commented = current_user
    comments = @post.comments.all
    parent_child_hash = Hash.new
    @nested_comment_list = Array.new

    comments.select{|i| i.parent_id==nil }.each do |comment|
      child_comments = comments.select{|cmt| cmt.parent_id==comment.id&&cmt.parent_id!=nil}
      parent_child_hash = {"comment" => comment, "child_comments" => child_comments }
      @nested_comment_list.push(parent_child_hash);
    end
    @comment = Comment.new
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
