class GoCritikMailer < ActionMailer::Base
  default from: "from@example.com"

 #  def deliver_text_to_email(text, email)
	# mail to: email, subject: text
 #  end

  def new_comment_email_to_reviewer(text, commentor, review)
    @commentor = commentor
    @review = review
    @reviewer = review.user
    mail to: @reviewer.email, subject: text
  end

  def new_comment_email_to_follower(text, follower, commentor, review)
  	@follower = follower
    @commentor = commentor
    @review = review
    mail to: follower.email, subject: text
  end

end