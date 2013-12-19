class FieldsValue < ActiveRecord::Base
  belongs_to :resource, inverse_of: :fields_values
  belongs_to :field

  validates :value, presence: true, if: "field.required"
  validates :value, uniqueness: true, if: "field.unique"
  validate :value, :data_type_of_field


  def data_type_of_field
    case field.input_type
    when 'String'
      errors.add(:value, "must be a #{ field.input_type.humanize }") unless value =~ /[\w]+/
    when 'Integer'
      errors.add(:value, "must be an #{ field.input_type.humanize }") unless value =~ /[\d]+/
    when 'Boolean'
      errors.add(:value, "must be an #{ field.input_type.humanize }") unless value =~ /[true|false]/
    end
  end
 
end