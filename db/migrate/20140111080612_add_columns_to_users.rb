class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
  	add_column :users, :ratings_count, :integer
  	add_column :users, :reviews_count, :integer
  end

  def self.down
  	remove_column :users, :ratings_count
  	remove_column :users, :reviews_count
  end
end
