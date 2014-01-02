class NotificationsController < ApplicationController
	def notifications
		@notifications = []
		EstadoArea.get_todays_notification(@notifications)
		Order.get_todays_notification(@notifications)
		respond_to do |format|
			format.json { render json: @notifications}
		end
	end
end