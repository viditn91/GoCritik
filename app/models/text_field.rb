class TextField < Field
  validates_with DefaultValueRegexpValidator

  def options
    nil
  end

  def sortable
    false
  end
  
end