require 'prawn'
class Report < ActiveRecord::Base
  attr_accessible :description, :name, :start, :type

  def self.plates(tipo, hora_in)
    @name = Time.now.to_s + " " + self.getHorario(tipo) + name + ".pdf"
    Prawn::Document.generate("public/pdf/"+ @name ) do |pdf|
      pdf.text("Reporte Platos " + @name + "- CUA " + Date.today.to_s)
      pdf.move_down 15
      OrderList.find_all_by_created_at(hora_in..Time.now).each do |order_list|
        if order_list.orders.count > 0
          pdf.text("Paciente: " +order_list.patient.nombre, :size => 10)
          pdf.text("Pieza: " +order_list.patient.num_pieza, :size => 10)          
           
        order_list.orders.find_all_by_horario(tipo).each do |order|
          if order.plates.count > 0
            pdf.text(self.getHorario(order.horario), :size => 10)
          end
          @text_plate = ""
          order.plates.each do |plate|
            @text_plate = @text_plate + plate.nombre + ", "            
          end
          pdf.text(@text_plate, :size => 10)
        end
        pdf.text("Fecha creacion " +order_list.created_at.to_s, :size => 10)  
        pdf.move_down 20
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
