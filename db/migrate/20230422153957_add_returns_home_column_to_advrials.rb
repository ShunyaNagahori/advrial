class AddReturnsHomeColumnToAdvrials < ActiveRecord::Migration[7.0]
  def change
    add_column :advrials, :returns_home_at, :datetime
  end
end
