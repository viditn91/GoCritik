class Resource < ActiveRecord::Base
  has_permalink :name

  scope :approved, -> { with_state(:approved) }
  scope :pending,  -> { with_state(:pending) }

  state_machine initial: :pending do
    state :pending, value: false
    state :approved, value: true

    event :approve do
      transition :pending => :approved
    end

    around_transition on: :approve do |resource, transition, block|
      resource.transaction do
        block.call
        resource.notify_concerned_user
      end
    end
  end

  with_options dependent: :destroy do |assoc|
    assoc.has_many :fields_values, inverse_of: :resource, validate: false
    assoc.has_many :reviews
    assoc.has_many :ratings
    assoc.has_one :picture, as: :imageable
  end

  accepts_nested_attributes_for :fields_values

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validate :validate_associated_fields

  after_validation :destroy_empty_associated_field_values

  liquid_methods :id, :fields_values

  def calc_avg_rating
    avg_rating = ratings_count == 0 ? 0 : (rating/ratings_count)
    avg_rating.round(2)
  end


  def get_field_value(field)
    value = fields_values.find { |el| el.field_id == field.id }.try(:value)
    if value
      case field
      when SelectBoxField, RadioButtonField
        field.get_disp_text(value)
      when CheckBoxField
        # Showing Check Box value as 'Yes' if checked
         "Yes"
      else
        value
      end
    elsif value == false
      # handling boolean value 'false' exception
      'false'
    else
      '- NA -'
    end
  end

  def latest_review
    reviews.order('updated_at').last
  end

  def notify_concerned_user
    GoCritikMailer.delay.resource_approval_mail(self)
  end

private
  
  def validate_associated_fields
    fields_values.each do |field_value|
      if field_value.invalid?
        field_value.errors[:base].try(:each) do |msg|
          errors[:base] << msg
        end
      end
    end
  end

  def destroy_empty_associated_field_values
    empty_fields_collection = fields_values.select do |field_value|
      field_value.value.blank?
    end
    fields_values.destroy empty_fields_collection
  end

end