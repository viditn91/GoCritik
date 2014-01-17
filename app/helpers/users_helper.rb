module UsersHelper

  def get_name(user)
    user.first_name.capitalize + " " + user.last_name.capitalize
  end

  def get_heading(title, user)
    if my_profile?(user)
      "My #{title.capitalize}"
    else
      "#{title.capitalize} by #{get_name(user)}"
    end
  end

  def show_error_message(msg)
    content_tag :li, msg, :id => "error_#{msg}" if msg.is_a?(String)
  end

  def my_profile?(user)
    current_user && current_user == user 
  end

  def has_profile_picture?(user)
    user.picture.photo.url != '/images/default/original/missing.jpg'
  end

end