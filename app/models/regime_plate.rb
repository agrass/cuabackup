class RegimePlate < ActiveRecord::Base
   attr_accessible :dia, :regime_id, :horario, :plate_id

  belongs_to :regime
  belongs_to :plate
end
