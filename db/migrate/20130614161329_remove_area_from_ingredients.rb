class RemoveAreaFromIngredients < ActiveRecord::Migration
  def change
  	remove_column :ingredients, :area_id
  end
end
