class TextAreaField < Field
  validates_with DefaultValueRegexpValidator

  def options=(value)
  	super nil
  end

  def sortable=(value)
    super false
  end
  
end