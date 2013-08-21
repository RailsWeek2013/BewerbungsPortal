class CreateLoas < ActiveRecord::Migration
  def change
    create_table :loas do |t|
      t.string :to
      t.string :street
      t.string :city
      t.string :zip
      t.string :subject
      t.text :what
      t.references :profile, index: true

      t.timestamps
    end
  end
end
