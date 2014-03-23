class Area < ActiveRecord::Base
  attr_accessible :descripcion, :nombre
  has_and_belongs_to_many :plates
  
  def self.get_plates_by_horario_and_area(horario, area, fecha)
  	OrderList.joins(orders: [plates: [:areas, :regimes]]).where(:fecha => fecha, orders: {:horario => horario.to_i}, areas: {:id => area.to_i}).select('plates.nombre as plato, count(*) as numero, regimes.nombre as regimen').group("regimes.nombre, plates.nombre")
  end
end
