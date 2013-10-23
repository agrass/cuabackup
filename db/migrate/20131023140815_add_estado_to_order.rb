class AddEstadoToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :estado, :integer
  end
end
