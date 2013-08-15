class User < ActiveRecord::Base
	has_secure_password

	validates :email, format:/\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i,
	uniqueness: true

end
