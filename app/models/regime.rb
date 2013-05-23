class Regime < ActiveRecord::Base

  attr_accessible :nombre, :regime_plates_attributes ,:plate_id, :dia
  has_many :regime_plates
  has_many :plates, :through => :regime_plates
  accepts_nested_attributes_for :regime_plates, :allow_destroy => true


  def get_plates_by_horario_and_dia(horario, dia)
    plates = self.plates.where(:regime_plates => {:dia => dia, :horario=> horario}).order(:tipo)
    #plates.select {|plate| plate.obtener_horarios.include?(horario) }
    plates
  end

  def self.obtenerPlatos(dia, horario, regimen_id, tipo)
    ids = Array.new
    Plate.find_all_by_tipo(tipo).each do |plt|
      ids << plt.id
    end
    return RegimePlate.find_all_by_dia_and_horario_and_regime_id_and_plate_id(dia, horario, regimen_id, ids )
  end


  def self.isActive(param, boton)
    if param == boton
      return "badge badge-success"
    else
      return "a"
    end
  end

end
