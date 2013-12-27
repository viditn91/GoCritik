class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :review, :user
      t.timestamps
    end
  end
end
