class AddVideoLinkToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :video_link, :string
  end
end
