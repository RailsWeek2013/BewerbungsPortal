class AddProfileToPlaces < ActiveRecord::Migration
  def change
    add_reference :places, :profile, index: true
  end
end
