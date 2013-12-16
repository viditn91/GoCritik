class FieldsValue < ActiveRecord::Base
  belongs_to :resource, inverse_of: :fields_values
  belongs_to :field

  validates :value, presence: true, if: "field.required"
  validates :value, uniqueness: true, if: "field.unique"
 
end