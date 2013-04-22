class CreateRegimes < ActiveRecord::Migration
  def change
    create_table :regimes do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
