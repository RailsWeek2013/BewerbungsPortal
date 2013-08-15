class AddParamsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :name, :string
    add_column :users, :birthday, :date
    add_column :users, :marial_status, :string
    add_column :users, :telefon, :string
  end
end
