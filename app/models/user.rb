class User < ActiveRecord::Base
	rolify
	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable

	validates :email, :uniqueness => true
	validates :rut, :uniqueness => true
	validates_each :rut do |record, attr, value|
		if not value =~ /[1-9]{8}[-][1-9k]/
    		record.errors.add(attr, 'Rut escrito de forma incorrecta')
    	end
    	s = value.split("-")
    	if User.getDigito(s[0]).to_s != s[1]
    		record.errors.add(attr, 'Rut invalido')
    	end
  	end

	# Setup accessible (or protected) attributes for your model
	attr_accessible :role_ids, :as => :admin
	attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :rut

	#def reset_token
	#	self.update_column(:token, SecureRandom.hex)
	#end

	def self.getDigito(rut)
		if rut.nil?
			return nil
		end
	    dvr='0'
	    suma=0
	    mul=2
	    rut.reverse.split("").each do |c|
	      suma=suma+c.to_i*mul
	      if mul==7
	        mul=2
	      else
	        mul+=1
	      end
	    end
	    res=suma%11
	    if res==1
	      return 'k'
	    elsif res==0
	      return '0'
	    else
	      return 11-res
	    end
	end
	
end
