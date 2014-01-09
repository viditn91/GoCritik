class FixValueInRatings < ActiveRecord::Migration
  def self.up
  	change_column :ratings, :value, :decimal, precision:2, scale: 1
  end
  def self.down
  	change_column :ratings, :value, :integer
  end
end