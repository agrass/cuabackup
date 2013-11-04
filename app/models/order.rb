class Order < ActiveRecord::Base
  attr_accessible :comentarios, :horario, :order_list_id, :regime_id, :estado
  before_save :set_state
  module Estados
    PorImprimir = 1
    Modificado = 2
    Ok = 3
    IngresadoAlerta = 4
    Pendiente = 5
  end

  private
  def set_state
    if self.estado == Estados::Ok
    	self.estado = Estados::Modificado
    else
    	date = OrderList.find(self.order_list_id).fecha
    	if date == Date.today
    		self.estado = Estados::IngresadoAlerta
    	else
    		self.estado = Estados::PorImprimir
    	end
    end
  end

  public
  def set_ok  	
    self.update_column(:estado, 3)
  end

  has_and_belongs_to_many :plates
  belongs_to :order_lists
  has_one :regime
end
