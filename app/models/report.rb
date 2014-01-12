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
    #Dir.mkdir("public/pdf/") unless File.exists?("public/pdf/")
    now = Time.now
    @name = now.to_s + " " + getHorario(tipo) + ".pdf"
    order_count = 0   
    Prawn::Document.generate("public/pdf/"+ @name, :page_layout => :landscape ) do |pdf|            
      @orders_list = OrderList.find_all_by_fecha(fecha) 
      Report.page_template(pdf, 4)   
      @orders_list.each do |order_list|
        if order_list.orders.find_all_by_horario_and_estado(tipo, estados).count > 0
          if order_count%3 == 0 && order_count != 0
            start_new_page
            Report.page_template(pdf, 4)            
          end
          @ticket = Bandeja.new
          @ticket.paciente = order_list.patient.nombre
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
        titulo_hoja = "<b> Lista Pedidos "+ Report.getHorario(tipo.to_i) + " #{area.nombre} - #{fecha}</b>"

        AreasPlates.find_all_by_area_id(area.id).each do |ap|        
            count =  OrderList.joins(orders: :plates).where(:fecha => fecha, plates: {id: ap.plate_id}, orders: { horario: tipo }).count          
            if count > 0
             platos_info << "<b>#{Plate.find(ap.plate_id).nombre}</b> " + count.to_s
            end        
        end
        if platos_info.count > 0
          text(titulo_hoja, :align => :center, :inline_format=>true, :font_size => 14)
          transparent(0.2) {image "public/assets/images/logo2.jpg", :scale => 2, :at => [bounds.left+200, bounds.top - 150]}
          text(" ")
          move_down 20
          move_down 20
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
      pdf.text_box ticket.observaciones, :at => [0, 45], :width => 260, :align => :left,  :size => 12, :inline_format=>true
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


