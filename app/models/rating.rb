class Rating < ActiveRecord::Base
  belongs_to :resource, counter_cache: true
  belongs_to :user, counter_cache: true

  validates :value, :user_id, :resource_id, presence:true
  validates :user_id, uniqueness: { scope: :resource_id }

  before_create :update_resource_rating
  before_update :value_change_on_update
  after_save :set_resource_delta_flag
  after_update :set_resource_delta_flag
  after_destroy :set_resource_delta_flag

  def update_resource_rating(change=nil)
    change ||= value
    resource_obj = resource
    resource_obj.rating += change
    resource_obj.save(validate: false)
  end

  def value_change_on_update
    unless !value_changed?
      value_change = value - value_was
      update_resource_rating(value_change)
    end
  end

  def set_resource_delta_flag
    resource_obj = self.resource
    resource_obj.delta = true
    resource_obj.save(validate: false)
  end

end