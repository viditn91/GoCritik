class TextAreaField < Field
  validates_with DefaultValueRegexpValidator

  def options
  	nil
  end
end