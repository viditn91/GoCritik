class CheckBoxField < Field
  # validates :default_value, absence: true
  # validates :options, absence: true
  # validates :unique, in: [false]

  def default_value
  	nil
  end

  def options
  	nil
  end

  def unique
  	false
  end

end