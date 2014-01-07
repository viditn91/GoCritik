class CreateFieldsValues < ActiveRecord::Migration
  def change
    create_table :fields_values do |t|
      t.integer :integer_val
      t.string :string_val
      t.text :text_val
      t.float :float_val
      t.boolean :boolean_val
      t.date :date_val
      t.time :time_val
      t.references :field, :resource

      t.timestamps
    end
  end
end