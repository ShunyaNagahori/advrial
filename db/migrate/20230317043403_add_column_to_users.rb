class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :account_name, :string
    add_column :users, :url, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :introduce, :string
    add_column :users, :gender, :integer, default: 0, null: false
  end
end
