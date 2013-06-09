class PlateIngredient < ActiveRecord::Base
  attr_accessible :cantidad, :ingredient_id, :plate_id
  belongs_to :plate
  belongs_to :ingredient
end
