class AddIdsToPlateIngredient < ActiveRecord::Migration
  def change
  	add_column :plate_ingredients, :plate_id, :integer
  	add_column :plate_ingredients, :ingredient_id, :integer
  end
end
