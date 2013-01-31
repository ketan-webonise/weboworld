module PostsHelper
  def get_child_comment_user(id)
    user = User.find(id)
    logger.info("#################{user.name.inspect}")
    user.name
  end
end
