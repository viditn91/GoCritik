class RadioButtonField < Field
  validates :options, presence: true
  # validates :default_value, absence: true
  # validates :unique, in: [false]
  # validates_with OptionsValidator

  def unique
  	false
  end

  def default_value
  	nil
  end
end