class AreasPlates < ActiveRecord::Base
  attr_accessible :area_id, :plate_id
  has_one :plate 
end
