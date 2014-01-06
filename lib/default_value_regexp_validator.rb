class DefaultValueRegexpValidator < ActiveModel::Validator
  
  def validate(record)
    if record.default_value.present? && !(record.default_value =~ record.get_regexp)
      record.errors[:default_value] << "must be a #{ record.input_type }."
    end
  end

end