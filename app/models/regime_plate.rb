class RegimePlate < ActiveRecord::Base
  attr_accessible :dia

  belongs_to :regime
  belongs_to :plate
end
