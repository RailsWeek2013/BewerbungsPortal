class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.date :time_start
      t.date :time_end
      t.string :desc
      t.string :type

      t.timestamps
    end
  end
end
