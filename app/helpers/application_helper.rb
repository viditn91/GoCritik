module ApplicationHelper
  
  def liquidize(content, arguments)
    Liquid::Template.parse(content).render(arguments, :filters => [LiquidFilters])
  end

end