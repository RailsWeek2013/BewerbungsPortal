class Profile < ActiveRecord::Base
  
  has_one :address, dependent: :destroy
  has_one :loa, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :knowledges, dependent: :destroy
  
  belongs_to :user, dependent: :destroy
  
  accepts_nested_attributes_for :address
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

end
