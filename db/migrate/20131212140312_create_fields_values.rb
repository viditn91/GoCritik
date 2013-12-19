class CreateFieldsValues < ActiveRecord::Migration
  def change
    create_table :fields_values do |t|
      t.text :value
      t.references :field, :resource

      t.timestamps
    end
  end
end
