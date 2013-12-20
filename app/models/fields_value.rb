class FieldsValue < ActiveRecord::Base
  
  attr_accessor :value
  belongs_to :resource, inverse_of: :fields_values
  belongs_to :field
  before_validation :prepare_validations
  
  def prepare_validations
    attribute = "#{field.input_type.downcase}_val".to_sym
    required = field.required
    input_type = field.input_type
    self.class.class_eval do
      validates attribute, presence: true
      validates attribute, uniqueness: true
      validates attribute, format: { with: /[\w]+/, message: "must be a #{input_type}" }
    end
  end
 
  def get_regexp(input_type)
    InputTypeHash.each do |hash|
      return hash[:regexp] if hash[:name] == input_type
    end
  end
  
  # validates :string_val, presence: true, if: "field.required && field.input_type == 'String'"
  # validates :string_val, uniqueness: true, if: "field.unique && field.input_type == 'String'"
  # validates :string_val, format: { with: /[\w]+/, message: "must be a String" }

  # validates :text_val, presence: true, if: "field.required && field.input_type == 'Text'"
  # validates :text_val, uniqueness: true, if: "field.unique && field.input_type == 'Text'"
  # validates :text_val, format: { with: /[\w]+/, message: "must be a Text" }

  # validates :integer_val, presence: true, if: "field.required && field.input_type == 'Integer'"
  # validates :integer_val, uniqueness: true, if: "field.unique && field.input_type == 'Integer'"
  # validates :integer_val, format: { with: /[\d]+/, message: "must be a Integer" }, if: "value"

  
  def value
    if new_record?
      @value
    else
      attribute = "#{field.input_type.downcase}_val".to_sym
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