class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :fields, :field_type, :type
  end
end
