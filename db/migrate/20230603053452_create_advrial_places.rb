class CreateAdvrialPlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :advrial_places do |t|
      t.reference :advrial, null: false, foreign_key: true
      t.reference :place, null: false, foreign_key: true
      t.timestamps
    end
    add_index :advrial_places, [:advrial_id, :place_id], unique: true
    remove_foreign_key :places, :advrials
    remove_column :places, :advrial_id
  end
end
