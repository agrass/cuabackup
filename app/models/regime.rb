class Regime < ActiveRecord::Base
  attr_accessible :nombre

  has_many :regime_plates
  has_many :plates, :through => :regime_plates
end
