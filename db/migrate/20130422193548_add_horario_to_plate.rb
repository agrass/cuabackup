class AddHorarioToPlate < ActiveRecord::Migration
  def change
  	add_column :plates, :horario, :integer
  end
end
