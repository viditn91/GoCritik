class Resource < ActiveRecord::Base
  has_permalink :name

  scope :approved, -> { where(approved: true) }
  scope :listed,   -> { where(approved: false) }

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
      if field.options.present?
        field.get_disp_text(value)
      elsif field.type == 'CheckBoxField'
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