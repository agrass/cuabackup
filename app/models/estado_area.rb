class EstadoArea < ActiveRecord::Base
	attr_accessible :fecha, :horario, :idArea

	def self.get_todays_notification(notifications)
		num_alerts = EstadoArea.where(:fecha => Date.today).count
		unless num_alerts == 0
			notifications << {:message => "#{num_alerts} areas modificadas hoy", :link => Rails.application.routes.url_helpers.reporte_areas_path}
		end
	end

  #crear la alerta, sera necesario ponerle la fecha??
  def self.create_alert(horario, id_plato)
    area_plate = AreasPlates.find_by_plate_id(id_plato)
    if area_plate != nil 
      id_area = area_plate.area_id
      if EstadoArea.find_by_horario_and_idArea(horario, id_area) == nil
        EstadoArea.create(:fecha => Date.today, :horario => horario, :idArea => id_area)
      end
    end
  end
  #borrar alerta
  def self.remove_alert(horario, id_area)
    estado = EstadoArea.find_by_horario_and_idArea(horario, id_area)
    if estado != nil
      estado.destroy
    end
  end

end
