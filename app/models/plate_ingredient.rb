class PlateIngredient < ActiveRecord::Base
  attr_accessible :cantidad

  belongs_to :plate
  belongs_to :ingredient
end
