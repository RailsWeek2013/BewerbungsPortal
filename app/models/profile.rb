class Profile < ActiveRecord::Base
  
  has_one :address, dependent: :destroy
  has_one :loa, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :knowledges, dependent: :destroy
  
  belongs_to :user, dependent: :destroy
  
  accepts_nested_attributes_for :address
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/default.png"
  has_attached_file :signature, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/default.png"

  after_create :send_welcome_email

  def incomplete_attributes
  	missin_attributes = []
  	m = missin_attributes
  	m << :firstName unless firstName?  	
  	m << :name unless name?
  	m << :birthday unless birthday?
  	m << :marialStatus unless marialStatus?
  	m << :telefon unless telefon?
  	m << :avatar_file_name unless avatar_file_name?

  	m
  end

  private 
	def send_welcome_email
		Notification.new_account(self).deliver
	end
end
