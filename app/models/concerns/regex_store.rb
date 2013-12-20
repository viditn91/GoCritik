module RegexStore
  extend ActiveSupport::Concern
    
  def get_regex(input_type)
    InputTypeHash.each do |hash|
      return hash[:regexp] if hash[:name] == input_type
    end
  end

end