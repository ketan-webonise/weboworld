require "acts_as_commentable"
class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  acts_as_commentable
  attr_accessible :description, :post_image, :video_link, :user_id
  mount_uploader :post_image, PostImageUploader
  validates :description, :presence => true

  def self.create_comment(comment,post_id,user_id,parent_id)
    post = Post.find(post_id)
    post.comments.create(:comment => comment, :user_id => user_id, :parent_id => parent_id )
  end

  def self.nested_comment(post)
    comments = post.comments.all
    parent_child_hash = Hash.new
    nested_comment_list = Array.new

    comments.select{|i| i.parent_id==nil }.each do |comment|
      child_comments = comments.select{|cmt| cmt.parent_id==comment.id&&cmt.parent_id!=nil}
      parent_child_hash = {"comment" => comment, "child_comments" => child_comments }
      nested_comment_list.push(parent_child_hash);
    end
    nested_comment_list
  end

  def self.get_ordered_comments(page)
    posts = Post.order("created_at DESC").all.paginate(:page => page, :per_page => 4);
    posts
  end
end
