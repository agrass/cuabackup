class EstadoArea < ActiveRecord::Base
	attr_accessible :fecha, :horario, :idArea

	def self.get_todays_notification(notifications)
		num_alerts = EstadoArea.where(:fecha => Date.today).count
		unless num_alerts == 0
			notifications << {:message => "#{num_alerts} areas modificadas hoy", :link => Rails.application.routes.url_helpers.reporte_areas_path}
		end
	end
end
