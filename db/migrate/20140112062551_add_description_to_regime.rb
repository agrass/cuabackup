class AddDescriptionToRegime < ActiveRecord::Migration
  def change
    add_column :regimes, :description, :string
  end
end
