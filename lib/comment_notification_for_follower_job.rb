class CommentNotificationForFollowerJob < Struct.new(:text, :followers, :commentor, :review)
  
  def perform
    followers.each do |f| 
      GoCritikMailer.new_comment_email_to_follower(text, f, commentor, review).deliver
    end
  end

  def max_attempts
    return 3
  end

end