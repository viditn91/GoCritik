class Resource < ActiveRecord::Base
  
  has_many :fields_values, inverse_of: :resource, dependent: :destroy, validate: false
  accepts_nested_attributes_for :fields_values

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true
  validate :validate_associated_fields

  after_validation :destroy_empty_associated_field_values

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