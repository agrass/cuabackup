class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :patient
      t.boolean :esPaciente
      t.integer :horario
      t.string :comentarios

      t.timestamps
    end
  end
end
