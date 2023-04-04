class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places, id: :string do |t|
      t.string :place_name
      t.datetime :date_time
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :description
      t.references :advrial, foreign_key: true, type: :string, null: false
      t.timestamps
    end
  end
end
