class CreateChangeLogs < ActiveRecord::Migration
  def change
    create_table :change_logs do |t|
      t.integer :plate_id
      t.integer :horario
      t.integer :tipo
      t.integer :user_id

      t.timestamps
    end
  end
end
