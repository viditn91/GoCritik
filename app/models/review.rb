class Review < ActiveRecord::Base
  belongs_to :resource
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
end
