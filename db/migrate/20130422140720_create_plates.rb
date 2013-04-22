class CreatePlates < ActiveRecord::Migration
  def change
    create_table :plates do |t|
      t.string :nombre
      t.integer :calorias
      t.integer :tipo

      t.timestamps
    end
  end
end
