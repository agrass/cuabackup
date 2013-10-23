class CreateEstadoAreas < ActiveRecord::Migration
  def change
    create_table :estado_areas do |t|
      t.integer :idArea
      t.date :fecha
      t.integer :horario

      t.timestamps
    end
  end
end
