class Order < ActiveRecord::Base
  attr_accessible :comentarios, :horario, :order_list_id, :regime_id, :estado
  before_save :set_state

  has_and_belongs_to_many :plates
  belongs_to :order_list
  has_one :regime

  module Estados
    PorImprimir = 1
    Modificado = 2
    Ok = 3
    IngresadoAlerta = 4
    Pendiente = 5
  end


  def self.get_todays_notification(notifications)
    alerts = OrderList.joins(:orders).where(:fecha => Date.today, orders: {:estado => [1,2,4]}).select("orders.horario, count(*) as count").group("orders.horario")   
    unless alerts.length == 0
      alerts.each do |alert|
        notifications << {:message => "Vouchers #{Report.getHorario(alert.horario)} pendientes (#{alert.count})", :link => Rails.application.routes.url_helpers.order_lists_path(:date => Date.today, :horario => alert.horario)}
      end
    end
  end

  private
  def set_state
    if self.estado == Estados::Ok
      self.estado = Estados::Modificado
    else      
      self.estado = Estados::PorImprimir      
    end
  end

  public
  def set_ok
    self.update_column(:estado, 3)
  end
  #revisar si es de hoy
  def check_is_today
    if OrderList.find(self.order_list_id).fecha == Date.today
      return true
    else
      return false
    end
  end
end
