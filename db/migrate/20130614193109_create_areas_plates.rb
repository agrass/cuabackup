class CreateAreasPlates < ActiveRecord::Migration
	def change
		create_table :areas_plates, :id => false do |t|
			t.integer :area_id
			t.integer :plate_id
		end
	end
end
