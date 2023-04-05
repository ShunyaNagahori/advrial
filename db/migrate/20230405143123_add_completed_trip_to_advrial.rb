class AddCompletedTripToAdvrial < ActiveRecord::Migration[7.0]
  def change
    add_column :advrials, :completed_trip, :boolean, default: false, null: false
    add_column :advrials, :public, :boolean, default: false, null: false
  end
end
