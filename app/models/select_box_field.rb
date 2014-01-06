class SelectBoxField < Field
  validates :options, presence: true
  # validates :default_value, absence: true
  # validates :unique, in: [false]
  # validates_with OptionsValidator

  def default_value
  	nil
  end

  def unique
  	false
  end

end