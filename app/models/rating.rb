class Rating < ActiveRecord::Base
  belongs_to :resource
  belongs_to :user

  validates :value, :user_id, :resource_id, presence:true
  validates :user_id, uniqueness: { scope: :resource_id }
end