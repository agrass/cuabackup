class EstadoArea < ActiveRecord::Base
  attr_accessible :fecha, :horario, :idArea

  def self.get_todays_notifications
  	estados = EstadoArea.where(:fecha => Date.today)
    notifications = []
    estados.each do |estado|
      notifications << {:id => estado.id, :message => "Hay un area que necesita ser actualizada", :link => "#", :delete_link => "#"}
    end
    return notifications
  end
end
