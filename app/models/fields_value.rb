class FieldsValue < ActiveRecord::Base
  
  attr_accessor :value

  belongs_to :resource, inverse_of: :fields_values
  belongs_to :field

  validates_with FieldValueValidator
  after_validation :populate_value_to_table

  def get_regexp
    InputTypeHash.each do |hash|
      return hash[:regexp] if hash[:name] == field.input_type
    end
  end

  def is_value_unique?
    attribute = "#{ field.input_type.downcase }_val".to_sym
    FieldsValue.where(field_id: field_id).each do |field_value|
      return false if value == field_value.try(attribute) && id != field_value.id
    end
  end

  def value
    if new_record?
      @value
    else
      attribute = "#{ field.input_type.downcase }_val".to_sym
      @value = try(attribute)
    end
  end

  def populate_value_to_table
    attribute = "#{ field.input_type.downcase }_val"
    eval "self.#{ attribute } = value"
  end

end