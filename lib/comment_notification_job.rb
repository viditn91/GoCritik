class CommentNotificationJob < Struct.new(:commentor, :review)
  
  def perform
  	reviewer = review.user
    if commentor != reviewer
      # sending mail to the reviewer
      GoCritikMailer.new_comment_email_to_reviewer(commentor, review).deliver
      # sending mail to the followers
      followers = review.comments.map(&:user) - [commentor]
      followers.each do |f| 
        GoCritikMailer.new_comment_email_to_follower(f, commentor, review).deliver
      end
    end
  end

  def max_attempts
    return 3
  end

end