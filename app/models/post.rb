class Post < ActiveRecord::Base
  attr_accessible :description, :post_image, :video_link
  mount_uploader :post_image, PostImageUploader
  validates :description, :presence => true

end
