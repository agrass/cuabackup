class AddTipoToRegimePlate < ActiveRecord::Migration
  def change
  	add_column :regime_plates, :tipo_comida, :integer
  end
end
