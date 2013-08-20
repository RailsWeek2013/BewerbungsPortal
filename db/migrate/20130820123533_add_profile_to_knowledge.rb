class AddProfileToKnowledge < ActiveRecord::Migration
  def change
    add_reference :knowledges, :profile, index: true
  end
end
