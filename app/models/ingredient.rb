class Ingredient < ActiveRecord::Base
  attr_accessible :nombre, :precio, :unidad, :area_id

  has_many :plate_ingredients
  has_many :plates, :through => :plate_ingredients
  has_one :area
end
