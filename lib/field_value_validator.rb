class FieldValueValidator < ActiveModel::Validator
  
  def validate(record)
    if record.field.required && record.value.nil?
      record.errors[:base] << "#{ record.field.name } cannot be empty."
    elsif record.field.unique && !record.is_value_unique?
      record.errors[:base] << "#{ record.field.name } is already taken."
    elsif !(record.value =~ record.get_regexp) && record.value
      record.errors[:base] << "#{ record.field.name } must be a #{ record.field.input_type }."
    end
  end

end
