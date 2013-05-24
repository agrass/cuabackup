class ChangeOrders < ActiveRecord::Migration
  def change
  	change_table(:orders) { |t| 
  		t.references(:order_list)
  		t.remove(:patient_id)
  		t.remove(:esPaciente)
  	}
  end
end
