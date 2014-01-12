class AddSortableToFields < ActiveRecord::Migration
  def self.up
  	add_column :fields, :sortable, :boolean
  end
  
  def self.down
  	remove_column :fields, :sortable
  end
end
