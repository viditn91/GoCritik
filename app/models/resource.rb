class Resource < ActiveRecord::Base
  has_permalink :name
  with_options dependent: :destroy do |assoc|
    assoc.has_many :fields_values, inverse_of: :resource, validate: false
    assoc.has_many :reviews, inverse_of: :resource
    assoc.has_many :ratings
    assoc.has_one :picture, as: :imageable
  end

  accepts_nested_attributes_for :fields_values

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true, uniqueness: true
  validate :validate_associated_fields

  after_validation :destroy_empty_associated_field_values

  scope :approved, -> { where(approved: true) }
  scope :listed,   -> { where(approved: false) }

  def calc_avg_rating
    ## fixed
    ## This method can be moved to Resource model.
    if ratings.present?
      rating_array = ratings.pluck(:value)
      (rating_array.inject{ |sum, el| sum + el }.to_f / rating_array.size).round(2)
    else
      0.00
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