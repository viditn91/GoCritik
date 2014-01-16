class SelectBoxField < Field
  validates :options, presence: true
  validates_with OptionsValidator

  def unique=(value)
    super false
  end

  def default_value=(value)
    super false
  end

  def searchable=(value)
    super false
  end

end