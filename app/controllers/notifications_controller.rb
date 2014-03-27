class NotificationsController < ApplicationController
	def notifications
		@notifications = []
		EstadoArea.get_todays_notification(@notifications)
		Order.get_todays_notification(@notifications)		
		render json: @notifications		
	end
end