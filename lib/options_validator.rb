class OptionsValidator < ActiveModel::Validator

  def validate(record)
    if record.options.present?
      record.options.each do |hash|
        if hash[:text].empty? || hash[:value].empty?
          record.errors[:options] << ":DisplayText/ Value cannot be a empty."
          break
        elsif hash[:value].present? && !(hash[:value] =~ record.get_regexp)
          record.errors[:options] << ":Value must be a #{ record.input_type }."
          break
        end
      end
    end
  end

end