class Plate < ActiveRecord::Base

  attr_accessible :calorias, :nombre, :tipo, :regime_ids, :horario, :plate_ingredients_attributes, :description, :area_ids, :foto
  has_many :plate_ingredients
  has_many :ingredients, :through => :plate_ingredients
  #has_and_belongs_to_many :regimes
  has_many :regime_plates
  has_many :regimes, :through => :regime_plates
  accepts_nested_attributes_for :plate_ingredients, :allow_destroy => true
  has_and_belongs_to_many :orders
  has_and_belongs_to_many :areas
  has_one :change_log
  has_one :areas_plates


  has_attached_file :foto, :styles => { :small => "250x250>" }
  validates_attachment_size :foto, :less_than => 5.megabytes
  validates_attachment_content_type :foto, :content_type => ['image/jpeg', 'image/png', 'image/jpg']

  def obtener_horarios
  	array = []
  	num = self.horario
    count = 0
  	while num > 0
  		array.append(num%2 * 2**count)
      count = count + 1
  		num /= 2
  	end
  	return array
  end

  def self.obtener_tipos(horario)
    tipos = nil
    acomp = "Acompa"
    case horario
    when 1
      tipos = [["Liquido",1],["Sandwich",2],["Salado", 3],["Untable",4], ["Bebida", 5], ["Reposteria", 6], ["Saborizantes", 11]]
    when 2
      tipos = [["Entrada",7], ["Plato de Fondo",8], [acomp.encode("UTF-8"),9], ["Postre",10]]
    when 4
      tipos = [["Liquido",1],["Sandwich",2],["Salado", 3],["Untable",4], ["Bebida", 5], ["Reposteria", 6], ["Saborizantes", 11]]
    when 8
      tipos = [["Entrada",7], ["Plato de Fondo",8], [acomp.encode("UTF-8"),9], ["Postre",10]]
    else
      tipos = [["Liquido",1],["Sandwich",2],["Salado", 3],["Untable",4], ["Bebida", 5], ["Reposteria", 6], ["Entrada",7], ["Plato de Fondo",8], [acomp.encode("UTF-8"),9], ["Postre",10], ["Saborizantes", 11]]
    end
    return tipos
  end

  def self.buscar_tipo(tipo)
    acomp = "Acompa"
    @valores = [["Liquido",1],["Sandwich",2],["Salado", 3],["Untable",4], ["Bebida", 5], ["Reposteria", 6], ["Entrada",7], ["P. Fondo",8], [acomp.encode("UTF-8"),9], ["Postre",10], ["Saborizantes", 11]]
    return @valores[tipo -1][0]
  end

 

  def self.horarios_nombre
    return [["Desayuno", 1], ["Almuerzo", 2], ["Once", 4], ["Cena", 8], ["Colacion", 16]]
  end
end
