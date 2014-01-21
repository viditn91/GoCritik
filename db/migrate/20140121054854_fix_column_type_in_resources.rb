class FixColumnTypeInResources < ActiveRecord::Migration
  def change
  	remove_column :resources, :approved
  	add_column :resources, :state, :boolean
  end
end
