class CreateRegimePlates < ActiveRecord::Migration
  def change
    create_table :regime_plates do |t|
      t.integer :dia

      t.timestamps
    end
  end
end
