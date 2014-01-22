class Like < ActiveRecord::Base
  belongs_to :likeable, polymorphic: true, touch: true
  belongs_to :user

  validates :likeable_id, :likeable_type, :user_id, presence: true
  validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id] }
end