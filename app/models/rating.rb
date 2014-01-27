class Rating < ActiveRecord::Base
  belongs_to :resource, counter_cache: true
  belongs_to :user, counter_cache: true

  validates :value, :user_id, :resource_id, presence:true
  validates :user_id, uniqueness: { scope: :resource_id }

  after_create :update_resource_rating
  after_update :value_change_on_update, :set_resource_delta_flag
  after_save :set_resource_delta_flag, :touch_associated_user_review
  after_destroy :value_change_on_destroy, :set_resource_delta_flag

private
  def update_resource_rating(change=nil)
    change ||= value
    resource_obj = resource
    resource_obj.rating += change
    resource_obj.save(validate: false)
  end

  def value_change_on_update
    if value_changed?
      value_change = value - value_was
      update_resource_rating(value_change)
    end
  end

  def value_change_on_destroy
    update_resource_rating(-self.value)
  end

  def set_resource_delta_flag
    resource_obj = self.resource
    resource_obj.delta = true
    resource_obj.save(validate: false)
  end

  def touch_associated_user_review
    user.reviews.find_by(resource_id: resource).try(:touch)
  end

end