class CreateDayRegimes < ActiveRecord::Migration
  def change
    create_table :day_regimes do |t|
        t.date :date
        t.integer :regime_day
      t.timestamps
    end
  end
end
