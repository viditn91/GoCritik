class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  has_many :likes, as: :likeable
end
