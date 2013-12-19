class CreateFieldsValues < ActiveRecord::Migration
  def change
    create_table :fields_values do |t|
      t.integer :int_val
      t.string :string_val
      t.text :text_val
      t.references :field, :resource

      t.timestamps
    end
  end
end
