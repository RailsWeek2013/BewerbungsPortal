class Loa < ActiveRecord::Base
  belongs_to :profile

  validates :to, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :zip, presence: true
  validates :subject, presence: true
  validates :what, presence: true
end
