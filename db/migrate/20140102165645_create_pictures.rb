class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :content_type, :string 
      t.string :filename, :string 
      t.binary :binary_data, :binary 
      # t.references :imageable, polymorphic: true
      t.references :user, :resource
      t.timestamps
    end
  end
end
