class AddSearchableToFields < ActiveRecord::Migration
  def self.up
  	add_column :fields, :searchable, :boolean
  end
  def self.down
  	remove_column :fields, :searchable
  end
end
