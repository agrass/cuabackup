class AddAreaIdToIngredients < ActiveRecord::Migration
  def change
  	add_column :ingredients, :area_id, :integer
  end
end
