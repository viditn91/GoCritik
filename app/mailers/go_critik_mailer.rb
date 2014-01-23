class GoCritikMailer < ActionMailer::Base
  default from: "admin@gocritik.com"

  def new_comment_email_to_reviewer(commentor, review)
    @commentor = commentor
    @review = review
    @reviewer = review.user
    text = "#{ commentor.full_name } commented on your Review"
    mail to: @reviewer.email, subject: text
  end

  def new_comment_email_to_follower(follower, commentor, review)
    @follower = follower
    @commentor = commentor
    @review = review
    text = "#{ commentor.full_name } commented on your a review on which you commented"
    mail to: follower.email, subject: text
  end

  def resource_approval_mail(resource)
    @resource = resource
    @user = User.find_by(id: resource.suggested_by)
    text = "Your suggestion for listing '#{ resource.name }' has been approved"
    mail to: @user.email, subject: text
  end

end