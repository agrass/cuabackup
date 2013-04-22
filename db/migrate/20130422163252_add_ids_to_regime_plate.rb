class AddIdsToRegimePlate < ActiveRecord::Migration
  def change
  	add_column :regime_plates, :plate_id, :integer
  	add_column :regime_plates, :regime_id, :integer
  end
end
