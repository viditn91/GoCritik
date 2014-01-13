class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.text :content
      t.string :controller
      t.string :action
      t.string :view_element

      t.timestamps
    end
  end
end
