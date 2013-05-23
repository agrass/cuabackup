class RemoveTimestampsOrderPlates < ActiveRecord::Migration
  def change
  	change_table(:orders_plates) { |t| t.remove_timestamps }
  end
end
