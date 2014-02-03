module UsersHelper

  def show_error_message(msg)
    content_tag :li, msg, :id => "error_#{msg}" if msg.is_a?(String)
  end

end