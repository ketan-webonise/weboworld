require "acts_as_commentable"
class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  acts_as_commentable
  attr_accessible :description, :post_image, :video_link, :user_id
  mount_uploader :post_image, PostImageUploader
  validates :description, :presence => true

  #comment on post
  def create_comment(comment,user_id,parent_id)
        self.comments.create(:comment => comment, :user_id => user_id, :parent_id => parent_id )
  end

  #getting comments on post with parent comment associated with children comments
  def nested_comment()
    comments = self.comments
    parent_child_hash = Hash.new
    nested_comment_list = Array.new

    comments.select{|i| i.parent_id==nil }.each do |comment|
      child_comments = comments.select{|cmt| cmt.parent_id==comment.id&&cmt.parent_id!=nil}
      parent_child_hash = {"comment" => comment, "child_comments" => child_comments }
      nested_comment_list.push(parent_child_hash);
    end
    nested_comment_list
  end

  #showing all comments on post in descending order
  def self.get_ordered_comments(page)
    posts = order("created_at DESC").all.paginate(:page => page, :per_page => 4);
    posts
  end
end
