class Order < ActiveRecord::Base
  attr_accessible :comentarios, :esPaciente, :horario, :patient

  has_and_belongs_to_many :plates
  belongs_to :patient
end
