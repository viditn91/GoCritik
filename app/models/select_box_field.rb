class SelectBoxField < Field
  validates :options, presence: true
  validates_with OptionsValidator

  def default_value
    nil
  end

  def unique
    false
  end

  def searchable
    false
  end

end