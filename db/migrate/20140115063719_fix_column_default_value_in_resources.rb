class FixColumnDefaultValueInResources < ActiveRecord::Migration
  def change
  	change_column :resources, :ratings_count, :integer, :default => 0
  	change_column :resources, :reviews_count, :integer, :default => 0
  end
end