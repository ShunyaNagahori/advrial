class CreateAdvrials < ActiveRecord::Migration[7.0]
  def change
    create_table :advrials, id: :string do |t|
      t.string :title, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
