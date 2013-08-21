class AddAttachmentSignatureToProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.attachment :signature
    end
  end

  def self.down
    drop_attached_file :profiles, :signature
  end
end
