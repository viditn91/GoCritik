class AddColumnsToResources < ActiveRecord::Migration
  def self.up
  	add_column :resources, :ratings_count, :integer
  	add_column :resources, :reviews_count, :integer
  	add_column :resources, :rating, :decimal, precision: 16, scale: 2, default: 0.00
  end

  def self.down
  	remove_column :resources, :ratings_count
  	remove_column :resources, :reviews_count
  	remove_column :resources, :rating
  end
end
