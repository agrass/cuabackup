class ChangeTipoToPlate < ActiveRecord::Migration
  def up
  	rename_column :regime_plates, :tipo_comida, :horario
  end

  def down
  	rename_column :regime_plates, :horario, :tipo_comida
  end
end
