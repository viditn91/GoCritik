class RadioButtonField < Field
  validates :options, presence: true
  validates_with OptionsValidator

  def unique=(value)
  	super false
  end

  def default_value=(value)
    super nil
  end

  def searchable=(value)
    super false
  end
end