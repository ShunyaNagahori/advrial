class AddUserReferecneToPlace < ActiveRecord::Migration[7.0]
  def change
    change_column_null :places, :advrial_id, true
    add_reference :places, :user, foreign_key: true
    add_column :places, :public, :boolean, default: false
    change_column_null :advrials, :start_date, true
    change_column_null :advrials, :end_date, true
    remove_column :advrials, :returns_home_at
  end
end
