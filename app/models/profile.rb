class Profile < ActiveRecord::Base
  
  has_one :address
  has_many :places, dependent: :destroy
  has_many :knowledges
  
  belongs_to :user, dependent: :destroy
  
  accepts_nested_attributes_for :address
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)