class FieldsValue < ActiveRecord::Base
  
  attr_accessor :value
  belongs_to :resource, inverse_of: :fields_values
  belongs_to :field
  before_validation :prepare_validations
  
  def prepare_validations
    attribute = "#{ field.input_type.downcase }_val".to_sym
    object = self
    input_type = field.input_type
    regexp = get_regexp(input_type)
    self.class.class_eval do
      reset_callbacks(:validate)
      validates attribute, presence: true, if: "#{ object.field.required }"
      validates attribute, uniqueness: true, if: "#{ object.field.unique }"
      validates attribute, format: { with: regexp, message: "must be a #{ input_type }" }, if: "#{ object.value.present? }"
    end
  end
 
  def get_regexp(input_type)
    InputTypeHash.each do |hash|
      return hash[:regexp] if hash[:name] == input_type
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

  def value=(val)
    if new_record?
      @value = val
    else
      attribute = "#{field.input_type.downcase}_val"
      eval "self.#{ attribute } = val"
    end
  end


end