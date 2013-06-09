class AddRutToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :rut, :string
  end
end
