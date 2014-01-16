class AddApprovedToResources < ActiveRecord::Migration
  def self.up
    add_column :resources, :approved, :boolean, :default => true
  end

  def self.dowm
  	remove_column :resources, :approved
  end 
end