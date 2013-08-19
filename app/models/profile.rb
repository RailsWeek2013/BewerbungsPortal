class Profile < ActiveRecord::Base
  has_one :address
  belongs_to(:user)
  accepts_nested_attributes_for :address
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
end
