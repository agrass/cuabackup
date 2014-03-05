class Area < ActiveRecord::Base
  attr_accessible :descripcion, :nombre
  has_and_belongs_to_many :plates
  
end
