class AddDetallesToPatient < ActiveRecord::Migration
  def change
  	add_column :patients, :detalles, :text
  end
end
