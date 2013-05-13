class Regime < ActiveRecord::Base

  attr_accessible :nombre, :regime_plates_attributes ,:plate_id, :dia
  has_many :regime_plates
  has_many :plates, :through => :regime_plates
  accepts_nested_attributes_for :regime_plates, :allow_destroy => true

  def self.obtenerPlatos(dia, horario, regimen_id)
    return RegimePlate.find_all_by_dia_and_horario_and_regime_id(dia, horario, regimen_id)
  end

  def self.isActive(param, boton)
    if param == boton
      return "badge badge-success"
    else
      return "a"
    end
  end

end
