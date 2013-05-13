class Patient < ActiveRecord::Base
  attr_accessible :nombre, :num_pieza
  has_many :orders
end
