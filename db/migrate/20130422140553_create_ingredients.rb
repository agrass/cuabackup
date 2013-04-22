class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :nombre
      t.integer :precio
      t.string :unidad

      t.timestamps
    end
  end
end
