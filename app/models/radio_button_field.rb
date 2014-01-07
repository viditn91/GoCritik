class RadioButtonField < Field
  validates :options, presence: true
  validates_with OptionsValidator

  def unique
  	false
  end

  def default_value
  	nil
  end
end