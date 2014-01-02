class Order < ActiveRecord::Base
  attr_accessible :comentarios, :horario, :order_list_id, :regime_id, :estado
  before_save :set_state

  has_and_belongs_to_many :plates
  belongs_to :order_lists
  has_one :regime

  module Estados
    PorImprimir = 1
    Modificado = 2
    Ok = 3
    IngresadoAlerta = 4
    Pendiente = 5
  end


  def self.get_todays_notification(notifications)
    num_alerts = Order.where(:estado => [Estados::Modificado, Estados::IngresadoAlerta]).count
    unless num_alerts == 0
      notifications << {:message => "#{num_alerts} ordenes modificadas hoy", :link => Rails.application.routes.url_helpers.order_lists_path(:date => Date.today)}
    end
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

end
