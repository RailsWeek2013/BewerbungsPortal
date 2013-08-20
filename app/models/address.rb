class Address < ActiveRecord::Base
  belongs_to :profile, dependent: :destroy
end
