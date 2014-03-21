class Regime < ActiveRecord::Base

  attr_accessible :nombre, :regime_plates_attributes ,:plate_id, :dia, :description
  has_many :regime_plates, :class_name => :regime_plates
  has_many :plates, :through => :regime_plates
  accepts_nested_attributes_for :regime_plates, :allow_destroy => true
  validates_length_of :nombre, :minimum => 3, :maximum => 10, :allow_blank => true

  def get_plates_by_horario_and_dia(horario, dia)
    plates = self.plates.where(:regime_plates => {:dia => dia, :horario=> horario}).order(:tipo)
    #plates.select {|plate| plate.obtener_horarios.include?(horario) }
    plates
  end

  def self.obtenerPlatos(dia, horario, regimen_id, tipo)
    ids = Array.new
    Plate.find_all_by_tipo(tipo).each do |plt|
      ids << plt.id
    end
    return RegimePlate.find_all_by_dia_and_horario_and_regime_id_and_plate_id(dia, horario, regimen_id, ids )
  end


  def self.isActive(param, boton)
    if param == boton
      return "badge badge-success"
    else
      return "a"
    end
  end

  def self.data_for_stats(date)
    horario_index = {'1'=>0, '2'=>1, '4'=>2, '8'=>3}
    regime_index = {}
    regimes = []
    Regime.all.each_with_index do |regime, i|
      regime_index[regime.id] = i
      regimes <<{:name => regime.nombre, :data=> [0,0,0,0]}
    end
    date2 = date.split('/')
    order_lists = OrderList.where(:fecha => date2[2]+'-'+date2[1]+'-'+date2[0])
    order_lists.each do |order_list|
      order_list.orders.each do |order|
        unless order.regime_id.nil?
          regimes[regime_index[order.regime_id]][:data][horario_index[order.horario.to_s]] += 1
        end
      end
    end
    return regimes
  end

  def self.get_names_hash
    regimes = {}
    Regime.all.each do |reg|
      regimes[reg.id] = reg.nombre
    end
    return regimes
  end

end
