class AddIndexToOrderListAndPatient < ActiveRecord::Migration
  def change
  	add_index :areas_plates, :area_id
  	add_index :areas_plates, :plate_id
  	add_index :order_lists, :fecha
  	add_index :orders, :order_list_id
  	add_index :orders_plates, :order_id
  	add_index :orders_plates, :plate_id
  	add_index :patients, :rut
  	add_index :plate_ingredients, :plate_id
  	add_index :plate_ingredients, :ingredient_id
	add_index :regime_plates, :plate_id
	add_index :regime_plates, :regime_id  	
  end
end
