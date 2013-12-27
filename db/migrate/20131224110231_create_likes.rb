class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true
      t.timestamps
    end
  end
end
