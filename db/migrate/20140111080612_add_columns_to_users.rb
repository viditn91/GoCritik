class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
  	add_column :users, :ratings_count, :integer, :default => 0
  	add_column :users, :reviews_count, :integer, :default => 0
  end

  def self.down
  	remove_column :users, :ratings_count, :default => 0
  	remove_column :users, :reviews_count, :default => 0
  end
end
