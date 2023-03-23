class CreateAdvrialCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :advrial_categories do |t|
      t.string :name_ja, null: false
      t.string :name_en, null: false
      t.timestamps
    end

    add_reference :advrials, :advrial_category, foreign_key: true
  end
end
