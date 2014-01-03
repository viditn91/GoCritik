class AddNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, default: "GoCritik"
    add_column :users, :last_name, :string, default: "Member"
  end
end