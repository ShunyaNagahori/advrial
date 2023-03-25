class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.string :place_name
      t.datetime :date_time
      t.string :address
      t.integer :latitude
      t.integer :longitude
      t.references :advrial, foreign_key: true, null: false
      t.timestamps
    end
  end
end
