class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :nombre
      t.string :num_pieza

      t.timestamps
    end
  end
end
