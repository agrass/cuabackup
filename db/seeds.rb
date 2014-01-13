# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
puts 'ROLES'
Role.delete_all
role = Role.find_or_create_by_name({ :name => 'Admin' }, :without_protection => true)
'role: ' << role.name
Role.find_or_create_by_name({ :name => 'Nutricionista' }, :without_protection => true)
'role: ' << role.name
Role.find_or_create_by_name({ :name => 'Cocina' }, :without_protection => true)
'role: ' << role.name

puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => 'Administrador', :rut => "12345678-9", :email => 'user@example.com', :password => 'changeme', :password_confirmation => 'changeme'
puts 'user: ' << user.name
user.add_role :admin
user.add_role :nutricionista
user.add_role :cocina

puts 'INGREDIENTS'
Ingredient.delete_all

Ingredient.create(:nombre => "Aceite de oliva",  :unidad => "L" )
Ingredient.create(:nombre => "Aceite vegetal ",  :unidad => "L" )
Ingredient.create(:nombre => "Aceituna Azapa",  :unidad => "GR" )
Ingredient.create(:nombre => "Aceituna verde rellena de pimentón",  :unidad => "GR" )
Ingredient.create(:nombre => "Acelga ",  :unidad => "KG" )
Ingredient.create(:nombre => "Aceto Balsámico",  :unidad => "L" )
Ingredient.create(:nombre => "Ácido ascórbico ",  :unidad => "GR" )
Ingredient.create(:nombre => "Agua mineral sin gas",  :unidad => "L" )
Ingredient.create(:nombre => "Aji de color ",  :unidad => "GR" )
Ingredient.create(:nombre => "Ajo en polvo ",  :unidad => "GR" )
Ingredient.create(:nombre => "Albahaca ",  :unidad => "GR" )
Ingredient.create(:nombre => "Alcachofa en conserva",  :unidad => "UN" )
Ingredient.create(:nombre => "Alcaparra",  :unidad => "GR" )
Ingredient.create(:nombre => "Aliño completo ",  :unidad => "GR" )
Ingredient.create(:nombre => "Almendra",  :unidad => "KG" )
Ingredient.create(:nombre => "Amapolas semillas",  :unidad => "GR" )
Ingredient.create(:nombre => "Anchoas",  :unidad => "KG" )
Ingredient.create(:nombre => "Apio ",  :unidad => "KG" )
Ingredient.create(:nombre => "Arándano ",  :unidad => "KG" )
Ingredient.create(:nombre => "Arroz ",  :unidad => "KG" )
Ingredient.create(:nombre => "Arroz arbóreo",  :unidad => "KG" )
Ingredient.create(:nombre => "Arroz integral",  :unidad => "KG" )
Ingredient.create(:nombre => "Arvejas",  :unidad => "KG" )
Ingredient.create(:nombre => "Atun lomo en aceite ",  :unidad => "UN" )
Ingredient.create(:nombre => "Atun lomo en agua ",  :unidad => "UN" )
Ingredient.create(:nombre => "Avena instantanea",  :unidad => "KG" )
Ingredient.create(:nombre => "Azafrán",  :unidad => "GR" )
Ingredient.create(:nombre => "Azucar flor ",  :unidad => "KG" )
Ingredient.create(:nombre => "Azúcar granulada",  :unidad => "KG" )
Ingredient.create(:nombre => "Azúcar rubia",  :unidad => "KG" )
Ingredient.create(:nombre => "Bebida mini ",  :unidad => "UN" )
Ingredient.create(:nombre => "Berries Mixtos ",  :unidad => "KG" )
Ingredient.create(:nombre => "Betarraga",  :unidad => "KG" )
Ingredient.create(:nombre => "Berros",  :unidad => "GR" )
Ingredient.create(:nombre => "Bicarbonato de sodio",  :unidad => "KG" )
Ingredient.create(:nombre => "Brandy o coñac",  :unidad => "L" )
Ingredient.create(:nombre => "Cabezas de espárrago en conserva",  :unidad => "UN" )
Ingredient.create(:nombre => "Cacao",  :unidad => "GR" )
Ingredient.create(:nombre => "Café ",  :unidad => "UN" )
Ingredient.create(:nombre => "Café descafeinado",  :unidad => "UN" )
Ingredient.create(:nombre => "Caldo concentrado",  :unidad => "KG" )
Ingredient.create(:nombre => "Callampas secas",  :unidad => "KG" )
Ingredient.create(:nombre => "Camarones",  :unidad => "KG" )
Ingredient.create(:nombre => "Canela ",  :unidad => "GR" )
Ingredient.create(:nombre => "Capeletti",  :unidad => "KG" )
Ingredient.create(:nombre => "Cebolla",  :unidad => "KG" )
Ingredient.create(:nombre => "Cebolla morada",  :unidad => "KG" )
Ingredient.create(:nombre => "Cebollín",  :unidad => "GR" )
Ingredient.create(:nombre => "Cereal corn flakes ",  :unidad => "KG" )
Ingredient.create(:nombre => "Cerezas",  :unidad => "KG" )
Ingredient.create(:nombre => "Cerveza",  :unidad => "L" )
Ingredient.create(:nombre => "Chalotas",  :unidad => "KG" )
Ingredient.create(:nombre => "Chamito o uno al día ",  :unidad => "UN" )
Ingredient.create(:nombre => "Champiñon fresco",  :unidad => "KG" )
Ingredient.create(:nombre => "Chips de chocolate",  :unidad => "GR" )
Ingredient.create(:nombre => "Chirimoya",  :unidad => "UN" )
Ingredient.create(:nombre => "Choclitos cocktail",  :unidad => "UN" )
Ingredient.create(:nombre => "Choclo",  :unidad => "KG" )
Ingredient.create(:nombre => "Chocolate bitter",  :unidad => "KG" )
Ingredient.create(:nombre => "Chocolate blanco",  :unidad => "KG" )
Ingredient.create(:nombre => "Chocolate de leche",  :unidad => "KG" )
Ingredient.create(:nombre => "Chorizo",  :unidad => "KG" )
Ingredient.create(:nombre => "Chuño",  :unidad => "KG" )
Ingredient.create(:nombre => "Ciboulette",  :unidad => "GR" )
Ingredient.create(:nombre => "Cilantro",  :unidad => "GR" )
Ingredient.create(:nombre => "Ciruelas secas",  :unidad => "KG" )
Ingredient.create(:nombre => "Clara de huevo",  :unidad => "L" )
Ingredient.create(:nombre => "Clavo de olor",  :unidad => "GR" )
Ingredient.create(:nombre => "Cocktail de frutas",  :unidad => "KG" )
Ingredient.create(:nombre => "Coco rallado",  :unidad => "GR" )
Ingredient.create(:nombre => "Colapez",  :unidad => "GR" )
Ingredient.create(:nombre => "Comino",  :unidad => "GR" )
Ingredient.create(:nombre => "Congrio",  :unidad => "KG" )
Ingredient.create(:nombre => "Cous Cous",  :unidad => "KG" )
Ingredient.create(:nombre => "Crema Chantilly ",  :unidad => "L" )
Ingredient.create(:nombre => "Crema de leche",  :unidad => "L" )
Ingredient.create(:nombre => "Curcuma",  :unidad => "GR" )
Ingredient.create(:nombre => "Curry ",  :unidad => "GR" )
Ingredient.create(:nombre => "Damasco",  :unidad => "KG" )
Ingredient.create(:nombre => "Diente de dragon",  :unidad => "KG" )
Ingredient.create(:nombre => "Dulce membrillo",  :unidad => "KG" )
Ingredient.create(:nombre => "Durazno ",  :unidad => "KG" )
Ingredient.create(:nombre => "Eneldo",  :unidad => "GR" )
Ingredient.create(:nombre => "Esparragos",  :unidad => "GR" )
Ingredient.create(:nombre => "Espinacas ",  :unidad => "KG" )
Ingredient.create(:nombre => "Estragon",  :unidad => "KG" )
Ingredient.create(:nombre => "Fideos cabello",  :unidad => "KG" )
Ingredient.create(:nombre => "Fideos corbatitas",  :unidad => "KG" )
Ingredient.create(:nombre => "Fideos espirales",  :unidad => "KG" )
Ingredient.create(:nombre => "Fideos FetuccinI",  :unidad => "KG" )
Ingredient.create(:nombre => "Fideos quifaros",  :unidad => "KG" )
Ingredient.create(:nombre => "Fideos mostaccioli",  :unidad => "KG" )
Ingredient.create(:nombre => "Fideos spaghetti n°5 ",  :unidad => "KG" )
Ingredient.create(:nombre => "Flan",  :unidad => "GR" )
Ingredient.create(:nombre => "Frambuesa ",  :unidad => "KG" )
Ingredient.create(:nombre => "Frutilla ",  :unidad => "KG" )
Ingredient.create(:nombre => "Galletas",  :unidad => "KG" )
Ingredient.create(:nombre => "Galletas agua light sin sal",  :unidad => "KG" )
Ingredient.create(:nombre => "Galletas de agua light",  :unidad => "KG" )
Ingredient.create(:nombre => "Galletas de salvado",  :unidad => "KG" )
Ingredient.create(:nombre => "Galletas de soda",  :unidad => "KG" )
Ingredient.create(:nombre => "Gelatina sin sabor ",  :unidad => "GR" )
Ingredient.create(:nombre => "Gnocchi",  :unidad => "KG" )
Ingredient.create(:nombre => "Harina",  :unidad => "KG" )
Ingredient.create(:nombre => "Harina de almendra",  :unidad => "KG" )
Ingredient.create(:nombre => "Harina integral",  :unidad => "KG" )
Ingredient.create(:nombre => "Helado",  :unidad => "L" )
Ingredient.create(:nombre => "Huevo ",  :unidad => "KG" )
Ingredient.create(:nombre => "Jalea ",  :unidad => "GR" )
Ingredient.create(:nombre => "Jamón",  :unidad => "KG" )
Ingredient.create(:nombre => "Jamón de pechuga de pavo",  :unidad => "KG" )
Ingredient.create(:nombre => "Jenjibre",  :unidad => "KG" )
Ingredient.create(:nombre => "Jugo de fruta",  :unidad => "L" )
Ingredient.create(:nombre => "Jugo de limón",  :unidad => "L" )
Ingredient.create(:nombre => "Kanikama",  :unidad => "KG" )
Ingredient.create(:nombre => "Ketchup",  :unidad => "KG" )
Ingredient.create(:nombre => "Kiwi",  :unidad => "KG" )
Ingredient.create(:nombre => "Lasaña",  :unidad => "KG" )
Ingredient.create(:nombre => "Laurel ",  :unidad => "GR" )
Ingredient.create(:nombre => "Leche condensada ",  :unidad => "KG" )
Ingredient.create(:nombre => "Leche de coco",  :unidad => "L" )
Ingredient.create(:nombre => "Leche descremada",  :unidad => "L" )
Ingredient.create(:nombre => "Leche entera",  :unidad => "L" )
Ingredient.create(:nombre => "Leche evaporada",  :unidad => "KG" )
Ingredient.create(:nombre => "Lechuga ",  :unidad => "KG" )
Ingredient.create(:nombre => "Lentejas",  :unidad => "KG" )
Ingredient.create(:nombre => "Levadura",  :unidad => "L" )
Ingredient.create(:nombre => "Limón",  :unidad => "KG" )
Ingredient.create(:nombre => "Lomo de cerdo",  :unidad => "KG" )
Ingredient.create(:nombre => "Lomo liso ",  :unidad => "KG" )
Ingredient.create(:nombre => "Maicena",  :unidad => "KG" )
Ingredient.create(:nombre => "Manjar ",  :unidad => "KG" )
Ingredient.create(:nombre => "Manteca",  :unidad => "KG" )
Ingredient.create(:nombre => "Mantequilla ",  :unidad => "KG" )
Ingredient.create(:nombre => "Manzanas ",  :unidad => "KG" )
Ingredient.create(:nombre => "Margarina",  :unidad => "KG" )
Ingredient.create(:nombre => "Masa philo",  :unidad => "UN" )
Ingredient.create(:nombre => "Mayonesa",  :unidad => "KG" )
Ingredient.create(:nombre => "Melon ",  :unidad => "KG" )
Ingredient.create(:nombre => "Membrillos",  :unidad => "KG" )
Ingredient.create(:nombre => "Merluza apanada",  :unidad => "KG" )
Ingredient.create(:nombre => "Mermelada ",  :unidad => "KG" )
Ingredient.create(:nombre => "Merquen ",  :unidad => "KG" )
Ingredient.create(:nombre => "Miel",  :unidad => "KG" )
Ingredient.create(:nombre => "Molida de Pavo",  :unidad => "KG" )
Ingredient.create(:nombre => "Molida de vacuno",  :unidad => "KG" )
Ingredient.create(:nombre => "Mora",  :unidad => "KG" )
Ingredient.create(:nombre => "Mostaza",  :unidad => "KG" )
Ingredient.create(:nombre => "Naranja",  :unidad => "KG" )
Ingredient.create(:nombre => "Nesquik ",  :unidad => "KG" )
Ingredient.create(:nombre => "Nueces",  :unidad => "KG" )
Ingredient.create(:nombre => "Nuez moscada",  :unidad => "KG" )
Ingredient.create(:nombre => "Oporto",  :unidad => "KG" )
Ingredient.create(:nombre => "Orégano",  :unidad => "KG" )
Ingredient.create(:nombre => "Palmitos",  :unidad => "KG" )
Ingredient.create(:nombre => "Paltas",  :unidad => "KG" )
Ingredient.create(:nombre => "Pan amasado",  :unidad => "KG" )
Ingredient.create(:nombre => "Pan baguette",  :unidad => "KG" )
Ingredient.create(:nombre => "Pan ciabatta",  :unidad => "KG" )
Ingredient.create(:nombre => "Pan de molde blanco unid",  :unidad => "KG" )
Ingredient.create(:nombre => "Pan de molde integral unid",  :unidad => "KG" )
Ingredient.create(:nombre => "Pan molde blanco",  :unidad => "KG" )
Ingredient.create(:nombre => "Pan molde integral",  :unidad => "KG" )
Ingredient.create(:nombre => "Pan rallado",  :unidad => "KG" )
Ingredient.create(:nombre => "Pan s/sal",  :unidad => "KG" )
Ingredient.create(:nombre => "Papa ",  :unidad => "KG" )
Ingredient.create(:nombre => "Papas duquesas",  :unidad => "KG" )
Ingredient.create(:nombre => "Papas prefritas",  :unidad => "KG" )
Ingredient.create(:nombre => "Papaya",  :unidad => "KG" )
Ingredient.create(:nombre => "Pasas rubias",  :unidad => "KG" )
Ingredient.create(:nombre => "Pastelera de choclo",  :unidad => "KG" )
Ingredient.create(:nombre => "Pate de ternera",  :unidad => "KG" )
Ingredient.create(:nombre => "Pechuga pavo",  :unidad => "KG" )
Ingredient.create(:nombre => "Pechuga pollo ",  :unidad => "KG" )
Ingredient.create(:nombre => "Pepino",  :unidad => "KG" )
Ingredient.create(:nombre => "Peras",  :unidad => "KG" )
Ingredient.create(:nombre => "Perejil",  :unidad => "KG" )
Ingredient.create(:nombre => "Petit pan francés Le fournil",  :unidad => "KG" )
Ingredient.create(:nombre => "Pimentón amarillo",  :unidad => "KG" )
Ingredient.create(:nombre => "Pimentón rojo",  :unidad => "KG" )
Ingredient.create(:nombre => "Pimentón verde",  :unidad => "KG" )
Ingredient.create(:nombre => "Pimienta",  :unidad => "KG" )
Ingredient.create(:nombre => "Piña ",  :unidad => "KG" )
Ingredient.create(:nombre => "Platanos",  :unidad => "KG" )
Ingredient.create(:nombre => "Polenta",  :unidad => "KG" )
Ingredient.create(:nombre => "Pollo ganso ",  :unidad => "KG" )
Ingredient.create(:nombre => "Polvos de hornear",  :unidad => "KG" )
Ingredient.create(:nombre => "Porotos",  :unidad => "KG" )
Ingredient.create(:nombre => "Porotos tortola ",  :unidad => "KG" )
Ingredient.create(:nombre => "Porotos verdes",  :unidad => "KG" )
Ingredient.create(:nombre => "Posta negra ",  :unidad => "KG" )
Ingredient.create(:nombre => "Posta rosada",  :unidad => "KG" )
Ingredient.create(:nombre => "Primavera",  :unidad => "KG" )
Ingredient.create(:nombre => "Pulpa de fruta",  :unidad => "KG" )
Ingredient.create(:nombre => "Quesillo",  :unidad => "KG" )
Ingredient.create(:nombre => "Quesillo sin sal",  :unidad => "KG" )
Ingredient.create(:nombre => "Queso chanco",  :unidad => "KG" )
Ingredient.create(:nombre => "Queso crema ",  :unidad => "KG" )
Ingredient.create(:nombre => "Queso gauda",  :unidad => "KG" )
Ingredient.create(:nombre => "Queso gruyere",  :unidad => "KG" )
Ingredient.create(:nombre => "Queso mantecoso",  :unidad => "KG" )
Ingredient.create(:nombre => "Queso mozarella",  :unidad => "KG" )
Ingredient.create(:nombre => "Queso parmesano",  :unidad => "KG" )
Ingredient.create(:nombre => "Queso roquefortt",  :unidad => "KG" )
Ingredient.create(:nombre => "Quinoa",  :unidad => "KG" )
Ingredient.create(:nombre => "Ravioles ",  :unidad => "KG" )
Ingredient.create(:nombre => "Reineta filete",  :unidad => "KG" )
Ingredient.create(:nombre => "Ricotta",  :unidad => "KG" )
Ingredient.create(:nombre => "Romero",  :unidad => "GR" )
Ingredient.create(:nombre => "Rucula",  :unidad => "KG" )
Ingredient.create(:nombre => "Sal ",  :unidad => "KG" )
Ingredient.create(:nombre => "Salmón ",  :unidad => "KG" )
Ingredient.create(:nombre => "Salsa barbecue",  :unidad => "L" )
Ingredient.create(:nombre => "Salsa caramelo ",  :unidad => "L" )
Ingredient.create(:nombre => "Salsa chocolate ",  :unidad => "L" )
Ingredient.create(:nombre => "Salsa de soya ",  :unidad => "L" )
Ingredient.create(:nombre => "Salsa frutilla",  :unidad => "L" )
Ingredient.create(:nombre => "Salsa Inglesa",  :unidad => "L" )
Ingredient.create(:nombre => "Salsa naranja ",  :unidad => "L" )
Ingredient.create(:nombre => "Salsa tomate",  :unidad => "KG" )
Ingredient.create(:nombre => "Sandia",  :unidad => "KG" )
Ingredient.create(:nombre => "Semola",  :unidad => "KG" )
Ingredient.create(:nombre => "Sucralosa",  :unidad => "UN" )
Ingredient.create(:nombre => "Te ",  :unidad => "UN" )
Ingredient.create(:nombre => "Te hierbas ",  :unidad => "UN" )
Ingredient.create(:nombre => "Tocino",  :unidad => "GR" )
Ingredient.create(:nombre => "Tomate Cherry",  :unidad => "KG" )
Ingredient.create(:nombre => "Tomates",  :unidad => "KG" )
Ingredient.create(:nombre => "Tomillo",  :unidad => "KG" )
Ingredient.create(:nombre => "Trutro largo ala ",  :unidad => "KG" )
Ingredient.create(:nombre => "Uva ",  :unidad => "KG" )
Ingredient.create(:nombre => "Vainilla ",  :unidad => "L" )
Ingredient.create(:nombre => "Vinagre ",  :unidad => "L" )
Ingredient.create(:nombre => "Vino blanco ",  :unidad => "L" )
Ingredient.create(:nombre => "Vino tinto ",  :unidad => "L" )
Ingredient.create(:nombre => "Yema de huevo",  :unidad => "KG" )
Ingredient.create(:nombre => "Yogurt batido ",  :unidad => "L" )
Ingredient.create(:nombre => "Yogurt descremado",  :unidad => "L" )
Ingredient.create(:nombre => "Yogurt natural  ",  :unidad => "L" )
Ingredient.create(:nombre => "Zanahoria",  :unidad => "KG" )
Ingredient.create(:nombre => "Zapallo camote ",  :unidad => "KG" )
Ingredient.create(:nombre => "Zapallo italiano",  :unidad => "KG" )

# Plate.destroy_all
# Ingredient.destroy_all
# RegimePlate.destroy_all
# Patient.destroy_all
# DayRegime.destroy_all
# Area.destroy_all
# #OrderList.destroy_all

# puts 'areas cocina'

# reposteria = Area.create(:nombre => "reposteria")
# cocina_fria = Area.create(:nombre => "Cocina fria")
# carnes = Area.create(:nombre => "Carnes")
# verduras = Area.create(:nombre => "Verduras")
# otros = Area.create(:nombre => "Otros")

# puts 'Platos'
# plate1 = Plate.create(:nombre => "Cafe" , :tipo => 1 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate2 = Plate.create(:nombre => "Te" , :tipo => 1 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate3 = Plate.create(:nombre => "Pan" , :tipo => 2 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')

# plate4 = Plate.create(:nombre => "Jamon" , :tipo => 3 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate5 = Plate.create(:nombre => "Palta" , :tipo => 3 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate6 = Plate.create(:nombre => "Tortilla Francesa" , :tipo => 3 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate7 = Plate.create(:nombre => "Queso" , :tipo => 3 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')

# plate8 =Plate.create(:nombre => "Mantequilla" , :tipo => 4 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate9 = Plate.create(:nombre => "Mermelada" , :tipo => 4 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate10 = Plate.create(:nombre => "Manjar" , :tipo => 4 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate11 = Plate.create(:nombre => "Miel" , :tipo => 4 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')

# plate12 = Plate.create(:nombre => "Jugo naranja" , :tipo => 5 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate13 = Plate.create(:nombre => "Yogurt" , :tipo => 5 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate14 = Plate.create(:nombre => "Yogurt" , :tipo => 5 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')

# plate15 = Plate.create(:nombre => "Pie de limon" , :tipo => 6 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate16 = Plate.create(:nombre => "2 Palmeritas" , :tipo => 6 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate17 = Plate.create(:nombre => "Bollo" , :tipo => 6 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate18 = Plate.create(:nombre => "Galletas" , :tipo => 6 , :horario => 5, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')

# plate19 = Plate.create(:nombre => "Consome" , :tipo => 7 , :horario => 10, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate20 = Plate.create(:nombre => "Albahaca y dados de tomate, palta, queso fresco" , :tipo => 7 , :horario => 10, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate21 = Plate.create(:nombre => "Quiche loreine" , :tipo => 7 , :horario => 10, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')

# plate22 = Plate.create(:nombre => "Reineta al horno" , :tipo => 8 , :horario => 10, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate23 = Plate.create(:nombre => "Bistec de lomo c/ salsa champiñon" , :tipo => 8 , :horario => 10, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')

# plate24 = Plate.create(:nombre => "Verduras a la mantequilla: Zapallito, zanahoria, champiñones" , :tipo => 9 , :horario => 10, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate25 = Plate.create(:nombre => "Arroz" , :tipo => 9 , :horario => 10, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate26 = Plate.create(:nombre => "Pure" , :tipo => 9 , :horario => 10, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# plate27 = Plate.create(:nombre => "Verduras a la mantequilla: Zapallito, zanahoria, champiñones" , :tipo => 9 , :horario => 10, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')

# Plate.create(:nombre => "Helado" , :tipo => 10 , :horario => 2, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')
# Plate.create(:nombre => "Fruta" , :tipo => 10 , :horario => 2, :description => 'Lorem ipsum ad his scripta blandit partiendo, eum fastidii accumsan euripidis in, eum liber hendrerit an. Qui ut wisi vocibus suscipiantur, quo dicit ridens inciderint id. Quo mundi lobortis reformidans eu, legimus senserit definiebas an eos.')

# puts 'Ingredientes'
# ingrediente1 = Ingredient.create(:nombre => "carne", :precio => 250, :unidad => "gramos")

# ingrediente2 = Ingredient.create(:nombre => "arroz", :precio => 100, :unidad => "gramos")
# ingrediente3 = Ingredient.create(:nombre => "lechuga", :precio => 100, :unidad => "gramos" )
# ingrediente4 = Ingredient.create(:nombre => "papas", :precio => 200, :unidad => "gramos" )
# ingrediente5 = Ingredient.create(:nombre => "cebolla", :precio => 150, :unidad => "gramos" )
# ingrediente6 = Ingredient.create(:nombre => "pollo", :precio => 450, :unidad => "gramos" )
# ingrediente7 = Ingredient.create(:nombre => "champiñones", :precio => 450, :unidad => "gramos")

# ingrediente8 = Ingredient.create(:nombre => "reineta", :precio => 450, :unidad => "gramos" )
# ingrediente9 = Ingredient.create(:nombre => "aceite", :precio => 10, :unidad => "ml" )
# ingrediente10 = Ingredient.create(:nombre => "sal", :precio => 5, :unidad => "gramos" )

# PlateIngredient.create(:cantidad => 5, :plate_id => plate25.id, :ingredient_id => ingrediente2.id)
# PlateIngredient.create(:cantidad => 5, :plate_id => plate25.id, :ingredient_id => ingrediente9.id)
# PlateIngredient.create(:cantidad => 5, :plate_id => plate25.id, :ingredient_id => ingrediente10.id)
# PlateIngredient.create(:cantidad => 3, :plate_id => plate22.id, :ingredient_id => ingrediente8.id)
# PlateIngredient.create(:cantidad => 2, :plate_id => plate23.id, :ingredient_id => ingrediente1.id)
# PlateIngredient.create(:cantidad => 2, :plate_id => plate23.id, :ingredient_id => ingrediente7.id)


# puts 'Pacientes'
# paciente1 = Patient.create(:nombre => "Pedro A", :rut => "17753853-4" , :num_pieza => "1A" )
# paciente2 = Patient.create(:nombre => "Rodrigo A", :rut => "17753345-8" , :num_pieza => "2A" )
# paciente3 = Patient.create(:nombre => "Fernando E", :rut => "13753853-3" , :num_pieza => "3A" )
# paciente4 = Patient.create(:nombre => "Joaquin F", :rut => "16753853-2" , :num_pieza => "4A" )
# paciente5 = Patient.create(:nombre => "Vicente V", :rut => "13753853-1" , :num_pieza => "5A" )


# puts 'dia regimen'

# DayRegime.create(:date => Date.new(2013, 4, 20), :regime_day => 1)


# puts 'Ordenes'

# ol1 = OrderList.create(:patient_id => paciente1.id, :esPaciente => true, :fecha => Date.today, :dia => DayRegime.getCurrentDay())
# ol2 = OrderList.create(:patient_id => paciente2.id, :esPaciente => true, :fecha => Date.today, :dia => DayRegime.getCurrentDay())
# ol3 = OrderList.create(:patient_id => paciente3.id, :esPaciente => true, :fecha => Date.today, :dia => DayRegime.getCurrentDay())
# ol4 = OrderList.create(:patient_id => paciente4.id, :esPaciente => true, :fecha => Date.today, :dia => DayRegime.getCurrentDay())
# ol5 = OrderList.create(:patient_id => paciente1.id, :esPaciente => false, :fecha => Date.today, :dia => DayRegime.getCurrentDay())
# ol6 = OrderList.create(:patient_id => paciente2.id, :esPaciente => false, :fecha => Date.today, :dia => DayRegime.getCurrentDay())

# or1 = Order.create(:horario => 1, :order_list_id => ol1.id, :regime_id => 1 )
# or2 = Order.create(:horario => 2, :order_list_id => ol2.id, :regime_id => 1 )
# or3 = Order.create(:horario => 4, :order_list_id => ol3.id, :regime_id => 1 )
# or4 = Order.create(:horario => 8, :order_list_id => ol4.id, :regime_id => 1 )
# or5 = Order.create(:horario => 1, :order_list_id => ol5.id, :regime_id => 1 )
# or6 = Order.create(:horario => 2, :order_list_id => ol6.id, :regime_id => 1 )

# puts 'Platos'

# or1.plates << plate1
# or2.plates << plate2
# or3.plates << plate3
# or4.plates << plate4
# or5.plates << plate5
# or6.plates << plate6
# or1.plates << plate7
# or2.plates << plate8
# or3.plates << plate9
# or4.plates << plate10
# or5.plates << plate11
# or6.plates << plate12
# or1.plates << plate13
# or2.plates << plate14
# or3.plates << plate15
# or4.plates << plate16
# or5.plates << plate17
# or6.plates << plate18
# or1.plates << plate19
# or2.plates << plate20
# or3.plates << plate21
# or4.plates << plate22
# or5.plates << plate23
# or6.plates << plate24
# or1.plates << plate25
# or2.plates << plate26
# or3.plates << plate27







