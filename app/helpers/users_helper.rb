module UsersHelper

  def get_name(user)
    user.first_name.capitalize + " " + user.last_name.capitalize
  end

  def get_heading(title, user)
    if current_user == user
      "My #{title.capitalize}"
    else
      "#{title.capitalize} by #{get_name(user)}"
    end
  end

end