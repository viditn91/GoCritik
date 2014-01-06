class TextAreaField < Field
  validates_with DefaultValueRegexpValidator
  # validates :options, absence: true

  def options
  	nil
  end
end