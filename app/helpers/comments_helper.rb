module CommentsHelper

  def get_new_comment_thumbnail
    if user_signed_in?
      image_tag current_user.picture.photo.url(:tiny)
    else
      image_tag "/images/default/tiny/missing.jpg"
    end
  end

end