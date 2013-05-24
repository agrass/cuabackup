class CreateOrderLists < ActiveRecord::Migration
  def change
    create_table :order_lists do |t|
    	t.references :patient
      	t.boolean :esPaciente

      t.timestamps
    end
  end
end
