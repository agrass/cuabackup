class Plate < ActiveRecord::Base
  attr_accessible :calorias, :nombre, :tipo, :regime_ids

  has_many :plate_ingredients
  has_many :ingredients, :through => :plate_ingredients

  
  has_many :regime_plates
  has_many :regimes, :through => :regime_plates

  def obtener_tipos
  	array = []
  	num = self.tipo
    count = 0
  	while num > 0
  		array.append(num%2 * 2**count)
      count = count + 1
  		num /= 2
  	end
  	return array
  end
end
