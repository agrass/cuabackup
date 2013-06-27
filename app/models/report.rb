# encoding: utf-8
require 'prawn'
class Report < ActiveRecord::Base
  attr_accessible :description, :name, :start, :type

  def self.plates(tipo, fecha)
    FileUtils.rm_rf("public/pdf/")   
    Dir.mkdir("public/pdf/") unless File.exists?("public/pdf/")
    now = Time.now
    @name = now.strftime("%d-%m-%Y").to_s + " " + getHorario(tipo) + name + ".pdf"    
    Prawn::Document.generate("public/pdf/"+ @name ) do           
      order_count = 0
      transparent(0.2) {image "public/assets/images/logo2.jpg", :scale => 1, :at => [bounds.left+300, bounds.top - 50]}
      transparent(0.2) {image "public/assets/images/logo2.jpg", :scale => 1, :at => [bounds.left+300, bounds.top - 300]}
      transparent(0.2) {image "public/assets/images/logo2.jpg", :scale => 1, :at => [bounds.left+300, bounds.top - 550]}
      OrderList.find_all_by_fecha(fecha).each do |order_list|
        if order_count%3 == 0 && order_count != 0
          start_new_page
        else
        if order_list.orders.find_all_by_horario(tipo).count > 0          
          font_size(8) {text " "}
          text("<b>Voucher Orden N#{order_list.id}     -  " + "#{now.strftime('%d/%m/%y')} </b>", :align => :center, :inline_format=>true )
          text(" ")
          text(" ")   
          text("<b>Nombre Completo</b> " +order_list.patient.nombre,  :align => :left, :inline_format=>true)          
          text("<b>Rut </b>  " +order_list.patient.rut, :align => :left, :inline_format=>true)
          text("<b> Pieza </b> " +order_list.patient.num_pieza, :align => :left, :inline_format=>true)                    
          
        order_list.orders.find_all_by_horario(tipo).each do |order|
          if order.plates.count > 0
            text("<b> Tipo Pedido </b> " + Report.getHorario(order.horario), :align => :left, :inline_format=>true)            
          end
          @text_plate = ""
          order.plates.each do |plate|
            @text_plate = @text_plate + plate.nombre + ", "            
          end
          text(" ")
          text("<b>Detalle pedido: </b>", :align => :left, :inline_format=>true)
           
          text(@text_plate)
        end
        text(" ") 
        text("<b>Fecha creacion </b>" +order_list.created_at.strftime('%d/%m/%y - %H:%M').to_s, :align => :left, :inline_format=>true)  
        move_down 20
        order_count = order_count + 1        
          text(" ") 
          text("------------------------------------------------------------------------------------------------------------------------------------")
          text(" ") 
        end
      end 
      end
    end

    return @name

  end

  def self.areas(tipo, fecha)
    FileUtils.rm_rf("public/pdf/")   
    Dir.mkdir("public/pdf/") unless File.exists?("public/pdf/")
    now = Time.now
    @name = now.strftime("%d-%m-%Y").to_s + " Pedidos Area.pdf"    
    Prawn::Document.generate("public/pdf/"+ @name ) do
         
      Area.all.each do |area|
        platos_info = Array.new
        titulo_hoja = "<b> Lista Pedidos "+ Report.getHorario(tipo) + " #{area.nombre} - #{fecha}</b>"     
        AreasPlates.find_all_by_area_id(area.id).each do |ap|        
            count =  OrderList.joins(orders: :plates).where(:fecha => fecha, plates: {id: ap.plate_id}, orders: { horario: tipo }).count          
            if count > 0
             platos_info << "<b>#{Plate.find(ap.plate_id).nombre}</b>                    " + count.to_s
            end        
        end
        if platos_info.count > 0
          text(titulo_hoja, :align => :center, :inline_format=>true, :font_size => 14)
          transparent(0.2) {image "public/assets/images/logo2.jpg", :scale => 2, :at => [bounds.left+200, bounds.top - 50]}
          text(" ")
          text("<b> Nombre Plato                   Cantidad </b>", :align => :left, :inline_format=>true)
          text("______________________________________________________________ ")
          platos_info.each do |plato_string|
            text(plato_string, :align => :left, :inline_format=>true) 
          end           
          start_new_page
        end
      end
  end

    return @name   

  end

  def self.getHorario(num)
    if num == 1 
      return "Desayuno"
    elsif num == 2
      return "Almuerzo"
    elsif num == 3
      return "Once"
    else
      return "Cena"
    end 
  end     
end
