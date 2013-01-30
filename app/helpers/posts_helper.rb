module PostsHelper
  def get_child_comment_user(id)
    user = User.find(id)
    user.name
  end
end
