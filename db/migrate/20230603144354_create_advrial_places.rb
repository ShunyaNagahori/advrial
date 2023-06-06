class CreateAdvrialPlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :advrial_places do |t|
      t.references :advrial, type: :string, null: false, foreign_key: true
      t.references :place, type: :string, null: false, foreign_key: true
      t.timestamps
    end
    
    add_index :advrial_places, [:advrial_id, :place_id], unique: true
    remove_reference :places, :advrial, type: :string
  end
end
