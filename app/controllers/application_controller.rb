class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "No tienes permiso"
  end

  def self.notifications?(current_user)
  	if current_user
  		if current_user.has_role? :admin or current_user.has_role? :central
  			return true
  		else 
  			return false
  		end
  	else
  		return false
  	end
  end
end
