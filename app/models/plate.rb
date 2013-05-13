class Plate < ActiveRecord::Base
  #TIPO
  PLATO_FONDO = 1
  ENTRADA = 2
  POSTRE = 3
  LIQUIDOS = 4 

  attr_accessible :calorias, :nombre, :tipo, :regime_ids, :horario, :plate_ingredients_attributes
  has_many :plate_ingredients
  has_many :ingredients, :through => :plate_ingredients
  accepts_nested_attributes_for :plate_ingredients, :allow_destroy => true
  has_and_belongs_to_many :orders

  def obtener_horarios
  	array = []
  	num = self.horario
    count = 0
  	while num > 0
  		array.append(num%2 * 2**count)
      count = count + 1
  		num /= 2
  	end
  	return array
  end
end
