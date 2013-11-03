class NotificationsController < ApplicationController
	def notifications
    @notifications = EstadoArea.get_todays_notifications
    respond_to do |format|
      format.json { render json: @notifications}
    end
  end
end