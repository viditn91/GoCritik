class AddSuggestedByToResources < ActiveRecord::Migration
  def change
  	add_column :resources, :suggested_by, :integer
  end
end
