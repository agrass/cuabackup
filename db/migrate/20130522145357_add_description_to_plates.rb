class AddDescriptionToPlates < ActiveRecord::Migration
  def change
  	add_column :plates, :description, :text
  end
end
