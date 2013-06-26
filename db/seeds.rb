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
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name({ :name => role }, :without_protection => true)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin
user.add_role :nutricionista
user.add_role :cocina

Plate.destroy_all
Ingredient.destroy_all
RegimePlate.destroy_all
Patient.destroy_all
DayRegime.destroy_all
Area.destroy_all
OrderList.destroy_all

puts 'areas cocina'

reposteria = Area.create(:nombre => "reposteria")
cocina_fria = Area.create(:nombre => "Cocina fria")
carnes = Area.create(:nombre => "Carnes")
verduras = Area.create(:nombre => "Verduras")
otros = Area.create(:nombre => "Otros")

puts 'Platos'
plate1 = Plate.create(:nombre => "Cafe" , :tipo => 1 , :horario => 5)
plate2 = Plate.create(:nombre => "Te" , :tipo => 1 , :horario => 5)
plate3 = Plate.create(:nombre => "Pan" , :tipo => 2 , :horario => 5)

plate4 = Plate.create(:nombre => "Jamon" , :tipo => 3 , :horario => 5)
plate5 = Plate.create(:nombre => "Palta" , :tipo => 3 , :horario => 5)
plate6 = Plate.create(:nombre => "Tortilla Francesa" , :tipo => 3 , :horario => 5)
plate7 = Plate.create(:nombre => "Queso" , :tipo => 3 , :horario => 5)

plate8 =Plate.create(:nombre => "Mantequilla" , :tipo => 4 , :horario => 5)
plate9 = Plate.create(:nombre => "Mermelada" , :tipo => 4 , :horario => 5)
plate10 = Plate.create(:nombre => "Manjar" , :tipo => 4 , :horario => 5)
plate11 = Plate.create(:nombre => "Miel" , :tipo => 4 , :horario => 5)

plate12 = Plate.create(:nombre => "Jugo naranja" , :tipo => 5 , :horario => 5)
plate13 = Plate.create(:nombre => "Yogurt" , :tipo => 5 , :horario => 5)
plate14 = Plate.create(:nombre => "Yogurt" , :tipo => 5 , :horario => 5)

plate15 = Plate.create(:nombre => "Pie de limon" , :tipo => 6 , :horario => 5)
plate16 = Plate.create(:nombre => "2 Palmeritas" , :tipo => 6 , :horario => 5)
plate17 = Plate.create(:nombre => "Bollo" , :tipo => 6 , :horario => 5)
plate18 = Plate.create(:nombre => "Galletas" , :tipo => 6 , :horario => 5)

plate19 = Plate.create(:nombre => "Consome" , :tipo => 7 , :horario => 10)
plate20 = Plate.create(:nombre => "Albahaca y dados de tomate, palta, queso fresco" , :tipo => 7 , :horario => 10)
plate21 = Plate.create(:nombre => "Quiche loreine" , :tipo => 7 , :horario => 10)

plate22 = Plate.create(:nombre => "Reineta al horno" , :tipo => 8 , :horario => 10)
plate23 = Plate.create(:nombre => "Bistec de lomo c/ salsa champiñon" , :tipo => 8 , :horario => 10)

plate24 = Plate.create(:nombre => "Verduras a la mantequilla: Zapallito, zanahoria, champiñones" , :tipo => 9 , :horario => 10)
plate25 = Plate.create(:nombre => "Arroz" , :tipo => 9 , :horario => 10)
plate26 = Plate.create(:nombre => "Pure" , :tipo => 9 , :horario => 10)
plate27 = Plate.create(:nombre => "Verduras a la mantequilla: Zapallito, zanahoria, champiñones" , :tipo => 9 , :horario => 10)

Plate.create(:nombre => "Helado" , :tipo => 10 , :horario => 2)
Plate.create(:nombre => "Fruta" , :tipo => 10 , :horario => 2)

puts 'Ingredientes'
ingrediente1 = Ingredient.create(:nombre => "carne", :precio => 250, :unidad => "gramos", :area_id => carnes.id )
ingrediente2 = Ingredient.create(:nombre => "arroz", :precio => 100, :unidad => "gramos", :area_id => otros.id )
ingrediente3 = Ingredient.create(:nombre => "lechuga", :precio => 100, :unidad => "gramos", :area_id => verduras.id )
ingrediente4 = Ingredient.create(:nombre => "papas", :precio => 200, :unidad => "gramos", :area_id => verduras.id )
ingrediente5 = Ingredient.create(:nombre => "cebolla", :precio => 150, :unidad => "gramos", :area_id => verduras.id )
ingrediente6 = Ingredient.create(:nombre => "pollo", :precio => 450, :unidad => "gramos", :area_id => carnes.id )
ingrediente7 = Ingredient.create(:nombre => "champiñones", :precio => 450, :unidad => "gramos", :area_id => verduras.id )
ingrediente8 = Ingredient.create(:nombre => "reineta", :precio => 450, :unidad => "gramos", :area_id => carnes.id )
ingrediente9 = Ingredient.create(:nombre => "aceite", :precio => 10, :unidad => "ml" )
ingrediente10 = Ingredient.create(:nombre => "sal", :precio => 5, :unidad => "gramos" )

PlateIngredient.create(:cantidad => 5, :plate_id => plate25.id, :ingredient_id => ingrediente2.id)
PlateIngredient.create(:cantidad => 5, :plate_id => plate25.id, :ingredient_id => ingrediente9.id)
PlateIngredient.create(:cantidad => 5, :plate_id => plate25.id, :ingredient_id => ingrediente10.id)
PlateIngredient.create(:cantidad => 3, :plate_id => plate22.id, :ingredient_id => ingrediente8.id)
PlateIngredient.create(:cantidad => 2, :plate_id => plate23.id, :ingredient_id => ingrediente1.id)
PlateIngredient.create(:cantidad => 2, :plate_id => plate23.id, :ingredient_id => ingrediente7.id)


puts 'Pacientes'
paciente1 = Patient.create(:nombre => "Pedro A", :rut => "17753853-4" , :num_pieza => "1A" )
paciente2 = Patient.create(:nombre => "Rodrigo A", :rut => "177533453-8" , :num_pieza => "2A" )
paciente3 = Patient.create(:nombre => "Fernando E", :rut => "13753853-3" , :num_pieza => "3A" )
paciente4 = Patient.create(:nombre => "Joaquin F", :rut => "16753853-2" , :num_pieza => "4A" )
paciente5 = Patient.create(:nombre => "Vicente V", :rut => "13753853-1" , :num_pieza => "5A" )


puts 'dia regimen'

DayRegime.create(:date => Date.new(2013, 4, 20), :regime_day => 1)


puts 'Ordenes'

ol1 = OrderList.create(:patient_id => paciente1.id, :esPaciente => true, :fecha => Date.today, :dia => DayRegime.getCurrentDay())
ol2 = OrderList.create(:patient_id => paciente2.id, :esPaciente => true, :fecha => Date.today, :dia => DayRegime.getCurrentDay())
ol3 = OrderList.create(:patient_id => paciente3.id, :esPaciente => true, :fecha => Date.today, :dia => DayRegime.getCurrentDay())
ol4 = OrderList.create(:patient_id => paciente4.id, :esPaciente => true, :fecha => Date.today, :dia => DayRegime.getCurrentDay())
ol5 = OrderList.create(:patient_id => paciente1.id, :esPaciente => false, :fecha => Date.today, :dia => DayRegime.getCurrentDay())
ol6 = OrderList.create(:patient_id => paciente2.id, :esPaciente => false, :fecha => Date.today, :dia => DayRegime.getCurrentDay())

or1 = Order.create(:horario => 1, :order_list_id => ol1.id, :regime_id => 1 )
or2 = Order.create(:horario => 2, :order_list_id => ol2.id, :regime_id => 1 )
or3 = Order.create(:horario => 4, :order_list_id => ol3.id, :regime_id => 1 )
or4 = Order.create(:horario => 8, :order_list_id => ol4.id, :regime_id => 1 )
or5 = Order.create(:horario => 1, :order_list_id => ol5.id, :regime_id => 1 )
or6 = Order.create(:horario => 2, :order_list_id => ol6.id, :regime_id => 1 )

puts 'Platos'

or1.plates << plate1
or2.plates << plate2
or3.plates << plate3
or4.plates << plate4
or5.plates << plate5
or6.plates << plate6
or1.plates << plate7
or2.plates << plate8
or3.plates << plate9
or4.plates << plate10
or5.plates << plate11
or6.plates << plate12
or1.plates << plate13
or2.plates << plate14
or3.plates << plate15
or4.plates << plate16
or5.plates << plate17
or6.plates << plate18
or1.plates << plate19
or2.plates << plate20
or3.plates << plate21
or4.plates << plate22
or5.plates << plate23
or6.plates << plate24
or1.plates << plate25
or2.plates << plate26
or3.plates << plate27







