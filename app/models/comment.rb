class Comment < ActiveRecord::Base
  belongs_to :review, touch: true
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  validates :review_id, :user_id, :content, presence: true

  after_commit :notify_the_reviewer_and_followers

private
  
  def notify_the_reviewer_and_followers
    Delayed::Job.enqueue CommentNotificationJob.new(user, review)
  end
end