class CreatePlateIngredients < ActiveRecord::Migration
  def change
    create_table :plate_ingredients do |t|
      t.integer :cantidad

      t.timestamps
    end
  end
end
