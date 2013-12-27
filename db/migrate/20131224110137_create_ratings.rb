class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :value
      t.references :user, :resource
      t.timestamps
    end
  end
end
