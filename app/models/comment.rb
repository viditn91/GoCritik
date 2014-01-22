class Comment < ActiveRecord::Base
  belongs_to :review, touch: true
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  validates :review_id, :user_id, :content, presence: true

  after_create :notify_the_reviewer, :notify_all_commentors

private
  
  def notify_the_reviewer
    reviewer = review.user
    if user != reviewer
      Delayed::Job.enqueue CommentNotificationForReviewerJob.new("#{ user.full_name } commented on your Review", 
        user, review)
    end
  end

  def notify_all_commentors
    reviewer = review.user
    followers = review.comments.map(&:user) - [user]
    if user != reviewer
      Delayed::Job.enqueue CommentNotificationForFollowerJob.new("#{ user.full_name } commented on the Review you had commented", 
        followers, user, review)
    end
  end 

end