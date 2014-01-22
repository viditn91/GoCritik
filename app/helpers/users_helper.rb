module UsersHelper

  def get_heading(title, user)
    if my_profile?(user)
      "My #{title.capitalize}"
    else
      "#{title.capitalize} by #{ user.full_name }"
    end
  end

  def show_error_message(msg)
    content_tag :li, msg, :id => "error_#{msg}" if msg.is_a?(String)
  end

  def my_profile?(user)
    current_user && current_user == user 
  end

end