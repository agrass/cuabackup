class Order < ActiveRecord::Base
  attr_accessible :comentarios, :horario, :order_list_id

  has_and_belongs_to_many :plates
  belongs_to :order_lists
end
