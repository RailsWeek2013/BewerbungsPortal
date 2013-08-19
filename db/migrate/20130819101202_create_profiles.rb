class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :firstName
      t.string :name
      t.date :birthday
      t.references :user, index: true
      t.string :marialStatus
      t.string :telefon
      t.timestamps
    end
  end
end
