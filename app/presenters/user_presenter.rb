class UserPresenter
  def initialize(user, template)
    @user = user
    @template = template
  end

  def h
    @template
  end

  def full_name
    @user.first_name.capitalize + " " + @user.last_name.capitalize
  end

  def avatar(size, css_class)
    h.image_tag(@user.picture.photo.url(size), class: css_class)
  end

  def remove_avatar
    if profile_picture_uploaded?
      h.link_to("Remove", h.picture_path(@user.picture, imageable_id: @user.id, imageable_type: @user.class.name), method: :delete)
    else
      "No Image uploaded"
    end
  end

  def edit_button
    h.link_to_if(:my_profile, "<i class='icon-pencil'></i>Edit".html_safe, h.edit_user_path(@user), class: 'btn')
  end

  def ratings_by_user
    @user.ratings_count
  end

  def reviews_by_user
    @user.reviews_count
  end

  def quantize_rating
    'rating'.pluralize(ratings_by_user).upcase    
  end

  def quantize_reviews
    'review'.pluralize(reviews_by_user).upcase    
  end

  def get_heading(title)
    if my_profile?
      "My #{title.capitalize}"
    else
      "#{title.capitalize} by #{ full_name }"
    end
  end

private
  def my_profile?
    h.current_user && h.current_user == @user
  end

  def profile_picture_uploaded?
    @user.picture.photo.url != '/images/default/original/missing.jpg'
  end
end