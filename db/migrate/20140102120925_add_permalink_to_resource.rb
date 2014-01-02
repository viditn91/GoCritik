class AddPermalinkToResource < ActiveRecord::Migration
  def self.up
    add_column :resources, :permalink, :string
    add_index :resources, :permalink
  end
  def self.down
    remove_column :resources, :permalink
  end
end