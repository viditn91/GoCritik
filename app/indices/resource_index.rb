ThinkingSphinx::Index.define :resource, :delta => true, :with => :active_record do
  join fields_values.field

  indexes :name, as: :name, facet: true
  where "approved = true"

  indexes description, as: :description, facet: true
  where "approved = true"
  
  indexes [fields_values.string_val, fields_values.text_val], as: :value, :facet => true
  where "fields.searchable = true"
  has rating, ratings_count, reviews_count

  set_property :field_weights => {
    :name => 10,
    :description => 3,
    :value => 1
  }

end