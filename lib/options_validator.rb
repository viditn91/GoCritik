class OptionsValidator < ActiveModel::Validator

  def validate(record)
    if record.options.present?
      valueArray = []
      record.options.each do |hash|
        valueArray << hash[:value]
        if hash[:text].empty? || hash[:value].empty?
          record.errors[:options] << ":DisplayText/ Value cannot be a empty."
          break
        elsif hash[:value].present? && !(hash[:value] =~ record.get_regexp)
          record.errors[:options] << ":Value must be a #{ record.input_type }."
          break
        elsif valueArray.uniq.length != valueArray.length
          record.errors[:options] << ":Value must be unique."
          break
        end
      end
    end
  end

end