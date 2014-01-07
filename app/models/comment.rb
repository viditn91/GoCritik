class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy

  validates :review_id, :user_id, :content, presence: true
end