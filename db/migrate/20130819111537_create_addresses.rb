class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :zip
      t.string :city
      t.references :profile, index: true

      t.timestamps
    end
  end
end
