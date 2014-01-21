class FieldValueValidator < ActiveModel::Validator
  
  def validate(record)
    if record.field.required && record.value.blank?
      record.errors[:base] << "#{ record.field.name } cannot be empty."
    elsif record.field.unique && !record.is_value_unique?
      record.errors[:base] << "#{ record.field.name } is already taken."
    elsif record.value.present? && !(record.value.to_s =~ record.field.get_regexp)
      record.errors[:base] << "#{ record.field.name } must be a #{ record.field.input_type }."
    end
  end

end	
