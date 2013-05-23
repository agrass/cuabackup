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

Plate.create(:nombre => "Cafe" , :tipo => 1 , :horario => 1)
Plate.create(:nombre => "Te" , :tipo => 1 , :horario => 1)
Plate.create(:nombre => "Pan" , :tipo => 2 , :horario => 1)

Plate.create(:nombre => "Jamon" , :tipo => 3 , :horario => 1)
Plate.create(:nombre => "Palta" , :tipo => 3 , :horario => 1)
Plate.create(:nombre => "Tortilla Francesa" , :tipo => 3 , :horario => 1)
Plate.create(:nombre => "Queso" , :tipo => 3 , :horario => 1)

Plate.create(:nombre => "Mantequilla" , :tipo => 4 , :horario => 1)
Plate.create(:nombre => "Mermelada" , :tipo => 4 , :horario => 1)
Plate.create(:nombre => "Manjar" , :tipo => 4 , :horario => 1)
Plate.create(:nombre => "Miel" , :tipo => 4 , :horario => 1)

Plate.create(:nombre => "Jugo naranja" , :tipo => 5 , :horario => 1)
Plate.create(:nombre => "Yogurt" , :tipo => 5 , :horario => 1)
Plate.create(:nombre => "Yogurt" , :tipo => 5 , :horario => 1)

Plate.create(:nombre => "Pie de limon" , :tipo => 6 , :horario => 1)
Plate.create(:nombre => "2 Palmeritas" , :tipo => 6 , :horario => 1)
Plate.create(:nombre => "Bollo" , :tipo => 6 , :horario => 1)
Plate.create(:nombre => "Galletas" , :tipo => 6 , :horario => 1)

Plate.create(:nombre => "Consome" , :tipo => 7 , :horario => 2)
Plate.create(:nombre => "Albahaca y dados de tomate, palta, queso fresco" , :tipo => 7 , :horario => 2)
Plate.create(:nombre => "Quiche loreine" , :tipo => 7 , :horario => 2)

Plate.create(:nombre => "Reineta al horno" , :tipo => 8 , :horario => 2)
Plate.create(:nombre => "Bistec de lomo c/ salsa champiñon" , :tipo => 8 , :horario => 2)

Plate.create(:nombre => "Verduras a la mantequilla: Zapallito, zanahoria, champiñones" , :tipo => 9 , :horario => 2)
Plate.create(:nombre => "Arroz" , :tipo => 9 , :horario => 2)
Plate.create(:nombre => "Pure" , :tipo => 9 , :horario => 2)
Plate.create(:nombre => "Verduras a la mantequilla: Zapallito, zanahoria, champiñones" , :tipo => 9 , :horario => 2)

Plate.create(:nombre => "Helado" , :tipo => 10 , :horario => 2)
Plate.create(:nombre => "Fruta" , :tipo => 10 , :horario => 2)


