class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
        t.string :name
        t.string :type
        t.string :description
        t.timestamp :start

      t.timestamps
    end
  end
end
