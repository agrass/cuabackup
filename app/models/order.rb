class Order < ActiveRecord::Base
  attr_accessible :comentarios, :horario, :order_list_id, :regime_id

  has_and_belongs_to_many :plates
  belongs_to :order_lists
  has_one :regime
end
