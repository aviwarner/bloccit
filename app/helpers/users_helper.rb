module UsersHelper
  def user_has_posts?(user)
    user.posts.length != 0
  end

  def user_has_comments?(user)
    user.comments.length != 0
  end

  def user_has_favorites?(user)
    user.favorites.length != 0
  end
end
