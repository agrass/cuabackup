class CambiarNombre < ActiveRecord::Migration
  def up
    rename_column :reports, :type, :tipo
  end

  def down
  end
end
