class Ingredient < ActiveRecord::Base
  attr_accessible :nombre, :precio, :unidad

  has_many :plate_ingredients
  has_many :plates, :through => :plate_ingredients
end
