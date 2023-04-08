class AddDisplayOrderToAdvrialCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :advrial_categories, :display_order, :integer, null: false, unique: true, default: 0
  end
end
