class ChangeLog < ActiveRecord::Base
  attr_accessible :horario, :plate_id, :tipo, :user_id
  ## DESCRIPCION CHANGE LOG:
  # Este modulo sirve para determinar cuando hubo un cambio en las ordenes y saber especificamente que plato fue el que se agrego o borro
  # esta cuenta de lo siguente: 
  # Horario: tipo de orden que fue modificada, desayuno, almuerzo, cena
  # plate_id: se hace referencia al plato que fue modificado
  # tipo : puede ser muy bien que se agrego (1) o que fue borrado (-1)
  # Al Momento de imprimir la ficha de la area se genera una tupla con valor tipo (0) para saber la hora en la cual hay que empezar a considerar las nuevas modificaciones.
  has_one :plate
end
