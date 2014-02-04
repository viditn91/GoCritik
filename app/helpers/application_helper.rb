module ApplicationHelper
  
  def liquidize(content, arguments)
    Liquid::Template.parse(content).render(arguments, :filters => [LiquidFilters])
  end

  def present(object, klass=nil)
  	klass ||= "#{ object.class }Presenter".constantize
  	presenter = klass.new(object, self)
  	yield presenter if block_given?
  	presenter
  end

  def get_searchable_fields
    Field.searchable.pluck(:name).prepend('name').map(&:downcase)
  end

end