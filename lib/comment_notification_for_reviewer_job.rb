class CommentNotificationForReviewerJob < Struct.new(:text, :commentor, :review)
  
  def perform
    GoCritikMailer.new_comment_email_to_reviewer(text, commentor, review).deliver
  end

  def max_attempts
    return 3
  end

end