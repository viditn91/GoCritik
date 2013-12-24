class FieldValidator < ActiveModel::Validator
  
  def validate(record)
    if record.default_value.present? && !(record.default_value =~ record.get_regexp)
      record.errors[:default_value] << "must be a #{ record.input_type }."
    end
    # if record.options.nil?
    #   record.errors[:options] << "cannnot be a empty set."
    # else
      record.options.try :each do |hash|
        if hash[:text].empty? || hash[:value].empty?
          record.errors[:options] << ":DisplayText/ Value cannot be a empty."
          break
        end
      end
      record.options.try :each do |hash|
        if hash[:value].present? && !(hash[:value] =~ record.get_regexp)
          record.errors[:options] << ":Value must be a #{ record.input_type }."
          break
        end
      end
    # end
  end

end	