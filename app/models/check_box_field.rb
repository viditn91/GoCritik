class CheckBoxField < Field

  def default_value=(value)
  	super nil
  end

  def options=(value)
  	super nil
  end

  def unique=(value)
  	super false
  end

  def searchable=(value)
  	super false
  end

  def sortable=(value)
    super false
  end

end