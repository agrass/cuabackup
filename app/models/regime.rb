class Regime < ActiveRecord::Base

  attr_accessible :nombre
  has_many :regime_plates
  has_many :plates, :through => :regime_plates
  accepts_nested_attributes_for :regime_plates, :allow_destroy => true

  def get_plates_by_horario(horario)
    plates = self.plates
    plates.select {|plate| plate.obtener_horarios.include?(horario) }
    plates
  end
end
