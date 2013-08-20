class Knowledge < ActiveRecord::Base
	belongs_to :profile, dependent: :destroy
end
