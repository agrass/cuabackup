class CreateOrdersPlates < ActiveRecord::Migration
  def change
    create_table :orders_plates do |t|
      t.references :order, :null => false
      t.references :plate, :null => false

      t.timestamps
    end
  end
end
