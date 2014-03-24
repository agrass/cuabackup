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
    #FileUtils.rm_rf("public/pdf/")   
    Dir.mkdir("public/pdf/") unless File.exists?("public/pdf/")
    now = Time.now
    @name = now.to_s + " " + getHorario(tipo) + ".pdf"
    order_count = 0   
    Prawn::Document.generate("public/pdf/"+ @name, :page_layout => :landscape ) do |pdf|            
      @orders_list = OrderList.find_all_by_fecha(fecha) 
      Report.page_template(pdf, 4)   
      @orders_list.each do |order_list|
        if order_list.orders.find_all_by_horario_and_estado(tipo, estados).count > 0
          if order_count%4 == 0 && order_count != 0
            pdf.start_new_page
            Report.page_template(pdf, 4)            
          end
          @ticket = Bandeja.new
          @ticket.paciente = order_list.patient.nombre[0..22]
          @ticket.habitacion =  order_list.patient.num_pieza
          @ticket.fecha =  "#{now.strftime('%d/%m/%y')}"
          @ticket.id = order_list.id                  
          order= order_list.orders.find_by_horario_and_estado(tipo, estados)
            if order != nil
              @ticket.servicio = Report.getHorario(order.horario)
              @ticket.regimen = Regime.find(order.regime_id).nombre
              @ticket.observaciones = order.comentarios
              order.set_ok            
              @ticket.menu = []         
              order.plates.each do |plate|
                @ticket.menu << [Plate.buscar_tipo(plate.tipo),  plate.nombre]            
              end       
              Report.fill_template(pdf, order_count%4, @ticket)
              order_count = order_count + 1 
            end               
                 
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
    FileUtils.rm_rf("public/pdf/")   
    Dir.mkdir("public/pdf/") unless File.exists?("public/pdf/")
    now = Time.now
    @name = now.to_s + " Pedidos Area.pdf"    
    Prawn::Document.generate("public/pdf/"+ @name ) do         
      Area.all.each do |area|
        platos_info = Array.new
        Area.get_plates_by_horario_and_area(tipo.to_i, area.id, fecha).each do |jn|
          platos_info << [jn.regimen, jn.plato, jn.numero.to_s]
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
            text_box plato_string[0][0..10], :at => [-10, temp_y], :width => 90, :align => :center, :size => 15
            text_box plato_string[1], :at => [105, temp_y], :width => 345, :align => :center, :size => 15
            text_box plato_string[2], :at => [465, temp_y], :width => 75, :align => :center, :size => 15
            temp_y = temp_y - 15 
            if temp_y < 15 
                start_new_page
                temp_y = 680
            end           
          end
           #agregar ficha de modificaciones
            cambios = Plate.joins([:change_log, :areas_plates]).where(:change_logs=>{:horario => tipo.to_i}, :areas_plates=>{:area_id => area.id}).select("change_logs.plate_id as plate_id, SUM(change_logs.tipo) as number, areas_plates.area_id").group(" change_logs.plate_id")
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
              text_box "DETALLE", :at => [265, 600], :width => 80, :align => :right, :size => 15
              transparent(0.8) { stroke_line [-15, 615], [560, 615] }
              transparent(0.8) { stroke_line [-15, 570], [560, 570] }
              transparent(0.8) { stroke_line [-15, 615], [-15, 0] }
              transparent(0.8) { stroke_line [262, 615], [262, 0] }               
              z = 560
              cambios.each do |cmb|
                text_box "#{Plate.find(cmb.plate_id).nombre}", :at => [0, z], :width => 260, :align => :left, :size => 12
                if cmb.number < 0
                  text_box "Se han eliminado un total de # #{cmb.number.to_i*-1}.", :at => [265, z], :width => 250, :align => :left, :size => 12
                else
                  text_box "Se han agregado un total de # #{cmb.number.to_i}.", :at => [265, z], :width => 250, :align => :left, :size => 12
                end
                z = z - 20
              end
            end           
          start_new_page
        end
      end
      EstadoArea.find_all_by_fecha(fecha).each do |ear|
        ear.destroy
      end
      ChangeLog.destroy_all
  end

    return @name   

  end

  def self.page_template(pdf, num)
    xin =  -10
    yin = 580
    x = 355
    y = 300
    pdf.transparent(0.8) { pdf.stroke_line [-30, 300], [900, 300] }
    pdf.transparent(0.8) { pdf.stroke_line [350, 5], [350, 900] }
    num.times do |i|
      pdf.bounding_box([xin, yin], :width => x, :height => y) do
          pdf.text_box "Ticket Bandeja", :at => [80, 245], :width => 170, :align => :center, :size => 18   
          pdf.transparent(0.6) {pdf.image "public/assets/images/logo2.jpg", :scale => 0.6, :at => [pdf.bounds.left, pdf.bounds.top - 10]}
          pdf.text_box "PACIENTE:", :at => [0, 225], :width => 150, :align => :left, :size => 12,:inline_format=>true
          pdf.text_box "SERVICIO:", :at => [0, 210], :width => 150, :align => :left, :size => 12, :inline_format=>true
          pdf.text_box "HABITACION:", :at => [0, 195], :width => 150, :align => :left,  :size => 12, :inline_format=>true
          pdf.text_box "REGIMEN:", :at => [0, 180], :width => 150, :align => :left,  :size => 12, :inline_format=>true
          #pdf.text_box "MENU:", :at => [0, 215], :width => 150, :align => :left,  :size => 12, :inline_format=>true 
          pdf.text_box "OBSERVACIONES:", :at => [0, 50], :width => 150, :align => :left,  :size => 12, :inline_format=>true         
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
    xin =  -10
    yin = 580
    x = 355
    y = 300
    if num == 1
      xin = x
    elsif num == 2
      yin = y
      xin  = -10
    elsif num ==3
      xin = x
      yin = y
    end    
    pdf.bounding_box([xin, yin], :width => x, :height => y) do     
      pdf.text_box ticket.paciente, :at => [78, 225], :width => 200, :align => :left, :size => 12,:inline_format=>true
      pdf.text_box ticket.servicio, :at => [78, 210], :width => 200, :align => :left, :size => 12, :inline_format=>true
      pdf.text_box ticket.habitacion, :at => [78, 195], :width => 200, :align => :left,  :size => 12, :inline_format=>true
      pdf.text_box ticket.regimen, :at => [78, 180], :width => 200, :align => :left,  :size => 12, :inline_format=>true
      pdf.transparent(0.3) { pdf.stroke_line [0, 165], [280, 165] }
      j = 160      
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
      pdf.text_box ticket.observaciones, :at => [0, 40], :width => 300, :align => :left,  :size => 12, :height => 30 ,:inline_format=>true
      #pdf.transparent(0.2) { pdf.stroke_bounds }        
    end
  end

  def self.getHorario(num)
    if num.to_i == 1 
      return "Desayuno"
    elsif num.to_i == 2
      return "Almuerzo"
    elsif num.to_i == 4
      return "Once"
    else
      return "Cena"
    end 
  end     
end


