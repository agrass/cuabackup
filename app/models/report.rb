# encoding: utf-8
require 'prawn'
class Bandeja  
   attr_accessor :paciente, :servicio, :habitacion, :regimen, :menu, :observaciones, :fecha, :id
   def initialize()
   end 
end
class Report < ActiveRecord::Base
  attr_accessible :description, :name, :start, :tipo

  def self.plates(tipo, fecha, estados)    
    begin 
      Dir.mkdir("public/pdf/") unless File.exists?("public/pdf/")
    rescue
    end
    now = Time.zone.now
    @name = now.to_s + " " + getHorario(tipo) + ".pdf"    

    order_count = 0   
    Prawn::Document.generate("public/pdf/"+ @name, :page_layout => :landscape ) do |pdf|            
      @orders_list = OrderList.joins(:orders).where(:fecha => fecha, orders: {:estado => estados, :horario => tipo })      
      Report.page_template(pdf, @orders_list.count > 3 ? 4 : @orders_list.count  )   
      @orders_list.each do |order_list|
        if order_count%4 == 0 && order_count != 0
          pdf.start_new_page
          Report.page_template(pdf, 4)  
        end
        @ticket = Bandeja.new
        @ticket.paciente = order_list.patient.nombre[0..22].split("(")[0]         
        @ticket.habitacion =  order_list.patient.num_pieza
        @ticket.habitacion = @ticket.habitacion + " [ACOMP]" if !order_list.esPaciente && !@ticket.habitacion.blank?
        @ticket.habitacion = "" if @ticket.habitacion.blank?
        @ticket.fecha =  "#{order_list.fecha.strftime('%d/%m/%y')}"
        @ticket.id = order_list.id                  
        order= order_list.orders.find_by_horario_and_estado(tipo, estados)
          if order != nil
            @ticket.servicio = Report.getHorario(order.horario)
            @ticket.regimen = Regime.find(order.regime_id).nombre
            @ticket.observaciones = order.comentarios
            order.set_ok            
            @ticket.menu = []         
            order.plates.each do |plate|
              @ticket.menu << [Plate.buscar_tipo(plate.tipo),  plate.nombre.split("[")[0]]            
            end       
            Report.fill_template(pdf, order_count%4, @ticket)
            order_count = order_count + 1 
          end    
      end
    end
    if order_count == 0      
      File.delete("public/pdf/" + @name)
      @name = "0"
    end

    return @name

  end

  def self.areas(tipo, fecha)    
    Dir.mkdir("public/pdf/") unless File.exists?("public/pdf/")
    now = Time.zone.now
    @name = now.to_s + " Pedidos Area.pdf"
    count_platos = 0
    Prawn::Document.generate("public/pdf/"+ @name ) do         
      Area.all.each do |area|
        platos_info = Array.new
        Area.get_plates_by_horario_and_area(tipo.to_i, area.id, fecha).each do |jn|
          platos_info << [jn.regimen, jn.plato.split("[")[0], jn.numero.to_s] 
          count_platos = count_platos + 1         
        end       
        if platos_info.count > 0
          text_box "PEDIDOS POR AREA", :at => [85, 720], :width => 300, :align => :center, :size => 20
          transparent(0.8) {image "public/assets/images/logo2.jpg", :scale => 0.8, :at => [8, 740]}
          #transparent(0.8) { stroke_line [-20, 695], [600, 695] }
          text_box "FECHA:", :at => [60, 680], :width => 80, :align => :right, :size => 15
          text_box fecha, :at => [150, 680], :width => 150, :align => :left, :size => 15 
          transparent(0.8) { stroke_line [145, 665], [400, 665] } 
          text_box "SERVICIO:", :at => [60, 660], :width => 80, :align => :right, :size => 15 
          text_box Report.getHorario(tipo.to_i), :at => [150, 660], :width => 150, :align => :left, :size => 15
          transparent(0.8) { stroke_line [145, 645], [400, 645] } 
          text_box "CUARTO:", :at => [60, 640], :width => 80, :align => :right, :size => 15
          text_box area.nombre, :at => [150, 640], :width => 150, :align => :left, :size => 15
          transparent(0.8) { stroke_line [145, 625], [400, 625] }  
          
          text_box "REGIMEN", :at => [-10, 610], :width => 100, :align => :center, :size => 15
          transparent(0.8) { stroke_line [-15, 615], [560, 615] }
          transparent(0.8) { stroke_line [-15, 595], [560, 595] }
          transparent(0.8) { stroke_line [-15, 615], [-15, 0] }
          transparent(0.8) { stroke_line [95, 615], [95, 0] }
          transparent(0.8) { stroke_line [455, 615], [455, 0] }
          transparent(0.8) { stroke_line [560, 615], [560, 0] }  
          text_box "PREPARACION", :at => [100, 610], :width => 350, :align => :center, :size => 15 
          text_box "RACIONES", :at => [460, 610], :width => 80, :align => :center, :size => 15 
          temp_y = 590     
          platos_info.each do |plato_string|
            text_box plato_string[0][0..10], :at => [-10, temp_y], :width => 90, :align => :left, :size => 15
            text_box plato_string[1][0..98], :at => [105, temp_y], :width => 345, :align => :left, :size => 15
            text_box plato_string[2], :at => [465, temp_y], :width => 75, :align => :center, :size => 15
            offset = 15
            if plato_string[1].length > 48
              offset = 30
            end
            temp_y = temp_y - offset 
            if temp_y < 15 
                start_new_page
                temp_y = 680
            end           
          end
           #agregar ficha de modificaciones
            cambios = Plate.joins([:change_log, :areas_plates]).where(:change_logs=>{:horario => tipo.to_i}, :areas_plates=>{:area_id => area.id}).select("change_logs.plate_id as plate_id, SUM(change_logs.tipo) as number, areas_plates.area_id").group(" change_logs.plate_id, areas_plates.area_id")
            if cambios.length > 0
              start_new_page
              text_box "CAMBIOS POR AREA", :at => [85, 720], :width => 300, :align => :center, :size => 20
              transparent(0.8) {image "public/assets/images/logo2.jpg", :scale => 0.8, :at => [8, 740]}
              #transparent(0.8) { stroke_line [-20, 695], [600, 695] }
              text_box "FECHA:", :at => [60, 680], :width => 80, :align => :right, :size => 15
              text_box fecha, :at => [150, 680], :width => 150, :align => :left, :size => 15 
              transparent(0.8) { stroke_line [145, 665], [400, 665] } 
              text_box "SERVICIO:", :at => [60, 660], :width => 80, :align => :right, :size => 15 
              text_box Report.getHorario(tipo.to_i), :at => [150, 660], :width => 150, :align => :left, :size => 15
              transparent(0.8) { stroke_line [145, 645], [400, 645] } 
              text_box "CUARTO:", :at => [60, 640], :width => 80, :align => :right, :size => 15
              text_box area.nombre, :at => [150, 640], :width => 150, :align => :left, :size => 15
              transparent(0.8) { stroke_line [145, 625], [400, 625] }
              text_box "NOMBRE", :at => [0, 600], :width => 80, :align => :right, :size => 15 
              text_box "DETALLE", :at => [390, 600], :width => 80, :align => :right, :size => 15
              transparent(0.8) { stroke_line [-15, 615], [560, 615] }
              transparent(0.8) { stroke_line [-15, 570], [560, 570] }
              transparent(0.8) { stroke_line [-15, 615], [-15, 0] }
              transparent(0.8) { stroke_line [380, 615], [380, 0] }               
              z = 560
              cambios.each do |cmb|
                count_platos = count_platos + 1
                nombre = Plate.find(cmb.plate_id).nombre.split("[")[0]
                text_box "#{nombre}", :at => [0, z], :width => 375, :align => :left, :size => 12
                if cmb.number.to_i < 0
                  text_box "Se han eliminado un total de # #{cmb.number.to_i*-1}.", :at => [390, z], :width => 250, :align => :left, :size => 12
                else
                  text_box "Se han agregado un total de # #{cmb.number.to_i}.", :at => [390, z], :width => 250, :align => :left, :size => 12
                end
                offset = 20
                if nombre.length > 48
                  offset = 35
                end
                if z < 35
                  start_new_page
                  z = 680
                end
                z = z - offset
              end
            end           
          start_new_page
        end
      end
      #si no tiene nada retorna
      return "0" if count_platos == 0
      #borrar los estado areas y logs especificos
      EstadoArea.find_all_by_fecha_and_horario(fecha, tipo.to_i).each do |ear|
        ear.destroy
      end
      ChangeLog.find_all_by_horario(tipo.to_i).each do |cl|
        cl.destroy
      end
  end

    return @name   

  end

  def self.page_template(pdf, num)
    xin =  -15
    yin = 525
    x = 365
    y = 240
    pdf.transparent(0.8) { pdf.stroke_line [-30, 300], [900, 300] }
    pdf.transparent(0.8) { pdf.stroke_line [355, 5], [355, 900] }
    num.times do |i|
      pdf.bounding_box([xin, yin], :width => x, :height => y) do
          pdf.text_box "Ticket Bandeja", :at => [80, 285], :width => 170, :align => :center, :size => 18
          pdf.transparent(0.3) { pdf.stroke_line [0, 268], [280, 268] }
          #pdf.transparent(0.6) {pdf.image "public/assets/images/logo2.jpg", :scale => 0.6, :at => [pdf.bounds.left, pdf.bounds.top - 10]}
          pdf.text_box "PACIENTE:", :at => [0, 265], :width => 150, :align => :left, :size => 12,:inline_format=>true
          pdf.text_box "SERVICIO:", :at => [0, 250], :width => 150, :align => :left, :size => 12, :inline_format=>true
          pdf.text_box "HABITACION:", :at => [0, 235], :width => 150, :align => :left,  :size => 12, :inline_format=>true
          pdf.text_box "REGIMEN:", :at => [0, 220], :width => 150, :align => :left,  :size => 12, :inline_format=>true
          #pdf.text_box "MENU:", :at => [0, 215], :width => 150, :align => :left,  :size => 12, :inline_format=>true 
          #pdf.text_box "OBSERVACIONES:", :at => [0, 70], :width => 150, :align => :left,  :size => 12, :inline_format=>true         
          #pdf.transparent(0.2) { pdf.stroke_bounds }     
          
      end
      if i == 0 
        xin = x
      elsif i == 1
        yin = y
        xin  = -10
      elsif i ==2
        xin = x
      end
    end      
  end

  def self.fill_template(pdf, num, ticket)
    xin = -15
    yin = 525
    x = 365
    y = 200
    if num == 1
      xin = x
    elsif num == 2
      yin = y
      xin  = -10
    elsif num ==3
      xin = x
      yin = y
    end    
    pdf.bounding_box([xin, yin], :width => 350, :height => 240) do     
      pdf.text_box ticket.paciente, :at => [78, 265], :width => 200, :align => :left, :size => 12,:inline_format=>true
      pdf.text_box ticket.servicio + " - " + ticket.fecha, :at => [78, 250], :width => 200, :align => :left, :size => 12, :inline_format=>true
      pdf.text_box ticket.habitacion, :at => [78, 235], :width => 200, :align => :left,  :size => 12, :inline_format=>true
      pdf.text_box ticket.regimen, :at => [78, 220], :width => 200, :align => :left,  :size => 12, :inline_format=>true
      pdf.transparent(0.3) { pdf.stroke_line [0, 205], [280, 205] }
      j = 200      
      ticket.menu.each do |plato|
        if j > 60
          pdf.text_box "#{plato[0]}:", :at => [0, j],:align => :left, :style => :bold,  :size => 12, :width => 70, :height => 25, :inline_format => true, :overflow => :truncate
          pdf.text_box plato[1], :at => [70, j],:align => :left,  :size => 12, :width => 265, :height => 25, :inline_format => true, :overflow => :truncate     
            if plato[1].length > 47
              j = j - 30
            else
              j = j - 15
            end
        end
      end
      pdf.transparent(0.4) { pdf.stroke_line [0, 65], [280, 65] }       
      pdf.text_box "OBSERVACIONES:" + ticket.observaciones[0..175], :at => [0, 64], :width => 360, :align => :left,  :size => 12, :height => 63 ,:inline_format=>true
      #pdf.transparent(0.2) { pdf.stroke_bounds }        
    end
  end

  def self.colacion(tipo, fecha, estados)
    Dir.mkdir("public/pdf/") unless File.exists?("public/pdf/")
    now = Time.zone.now
    @name = now.to_s + " " + "Colacion" + ".pdf"
    order_count = 0
    @orders = OrderList.joins(:orders).where(:fecha => fecha, :orders => { :horario => tipo, :estado => estados }).select("order_lists.patient_id, order_lists.esPaciente, order_lists.fecha, orders.horario, orders.comentarios, orders.id as order_id")
    Prawn::Document.generate("public/pdf/"+ @name, :page_layout => :landscape ) do |pdf|      
      xin = -10
      yin = 580
      x = 360
      y = 200
      count = 1      
      @orders.each do |col|
        pdf.bounding_box([xin, yin], :width => 350, :height => 240) do
            pdf.text_box "Ticket Colación " + (col.fecha.strftime('%d/%m/%y') || ""), :at => [30, 180], :width => 220, :align => :center, :size => 18
            pdf.transparent(0.3) { pdf.stroke_line [0, 160], [280, 160] }
            #pdf.transparent(0.6) {pdf.image "public/assets/images/logo2.jpg", :scale => 0.6, :at => [pdf.bounds.left, pdf.bounds.top - 10]}
            pdf.text_box "PACIENTE: " + (Patient.find(col.patient_id).try(:nombre)[0..22].split("(")[0]  || ""), :at => [0, 150], :width => 340, :align => :left, :size => 12,:inline_format=>true
            pdf.text_box "HABITACION: " + (Patient.find(col.patient_id).try(:num_pieza) || "") + (col.esPaciente ? '' : ' [ACOMP]'), :at => [0, 135], :width => 340, :align => :left, :size => 12, :inline_format=>true
            pdf.text_box "DESCRIPCIÓN: " + col.comentarios, :at => [0, 120], :width => 340, :align => :left,  :size => 12, :inline_format=>true
            Order.find(col.try(:order_id)).try(:set_ok)             
        end
        if count == 6
          pdf.start_new_page
          xin = -10
          yin = 580
          count = 0
        elsif count == 3 
          xin = 355
          yin = 580        
        else
          yin = yin - 193
        end
        count = count + 1
      end
    end
    if @orders.blank?      
      File.delete("public/pdf/" + @name)
      @name = "0"
    end
    return @name
  end

  def self.getHorario(num)
    if num.to_i == 1 
      return "Desayuno"
    elsif num.to_i == 2
      return "Almuerzo"
    elsif num.to_i == 4
      return "Once"
    elsif num.to_i == 8
      return "Cena"
    else
      return "Colacion"
    end
  end     
end


