class AddFechaAndDiaToOrderList < ActiveRecord::Migration
  def change
  	add_column :order_lists, :fecha, :date
  	add_column :order_lists, :dia, :integer
  	add_column :orders, :regime_id, :integer
  end
end
