class User < ActiveRecord::Base
	rolify
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable

	validates :email, :uniqueness => true
	validates :rut, :uniqueness => true

	# Setup accessible (or protected) attributes for your model
	attr_accessible :role_ids, :as => :admin
	attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :rut

	#def reset_token
	#	self.update_column(:token, SecureRandom.hex)
	#end
	
	
end
