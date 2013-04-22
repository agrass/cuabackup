class PlateIngredient < ActiveRecord::Base
  attr_accessible :cantidad, :ingredient_id
  belongs_to :plate
  belongs_to :ingredient
end
