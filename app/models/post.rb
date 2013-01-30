require "acts_as_commentable"
class Post < ActiveRecord::Base
  acts_as_commentable
  attr_accessible :description, :post_image, :video_link, :user_id
  mount_uploader :post_image, PostImageUploader
  #validates :description, :presence => true
end
