# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
# Examples:
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html


# puts 'ROLES'
#  Role.delete_all
#  role = Role.find_or_create_by_name({ :name => 'admin' }, :without_protection => true)
#  'role: ' << role.name
#  Role.find_or_create_by_name({ :name => 'nutricionista' }, :without_protection => true)
#  'role: ' << role.name
#  Role.find_or_create_by_name({ :name => 'central' }, :without_protection => true)
#  'role: ' << role.name

#  puts 'DEFAULT USERS'
#  User.delete_all
#  user = User.find_or_create_by_email :name => 'Administrador', :rut => "00000000-0", :email => 'user@example.com', :password => '12341234', :password_confirmation => '12341234'
#  puts 'user: ' << user.name
#  user.add_role :admin
#  user.add_role :nutricionista
#  user.add_role :central

#   us1 = User.find_or_create_by_email :name => 'Geraldine Perret', :rut => "16139840-3", :email => 'gperret@clinicauandes.cl', :password => '12341234', :password_confirmation => '12341234'
#   us2 = User.find_or_create_by_email :name => 'Barbara Castillo', :rut => "16388605-7", :email => 'bcastillo@clinicauandes.cl', :password => '12341234', :password_confirmation => '12341234'
#   us3 = User.find_or_create_by_email :name => 'Macarena Araya', :rut => "15019976-k", :email => 'maraya@clinicauandes.cl', :password => '12341234', :password_confirmation => '12341234'
#   us4 = User.find_or_create_by_email :name => 'Carolina Garcia', :rut => "16589834-6", :email => 'cgarciasilva@clinicauandes.cl', :password => '12341234', :password_confirmation => '12341234'
#   us5 = User.find_or_create_by_email :name => 'Loreto Varas', :rut => "12846631-2", :email => 'lvaras@clinicauandes.cl', :password => '12341234', :password_confirmation => '12341234'
#   us6 = User.find_or_create_by_email :name => 'Marcela Contreras', :rut => "16919467-k", :email => 'mcontreras@clinicauandes.cl', :password => '12341234', :password_confirmation => '12341234'
#   us7 = User.find_or_create_by_email :name => 'Cristina', :rut => "0-0", :email => 'user@example.com', :password => '12341234', :password_confirmation => '12341234'
#   us8 = User.find_or_create_by_email :name => 'Evelyn Flores', :rut => "15781531-8", :email => 'eflores@clinicauandes.cl', :password => '12341234', :password_confirmation => '12341234'
#   us9 = User.find_or_create_by_email :name => 'Maria Ignacia Fillol', :rut => "16211533-2", :email => 'mfillol@clinicauandes.cl', :password => '12341234', :password_confirmation => '12341234'
#   us1.add_role :nutricionista
#   us2.add_role :nutricionista
#   us3.add_role :nutricionista
#   us4.add_role :admin
#   us4.add_role :nutricionista
#   us4.add_role :central
#   us5.add_role :nutricionista
#   us5.add_role :nutricionista
#   us6.add_role :nutricionista
#   us7.add_role :admin
#   us7.add_role :nutricionista
#   us7.add_role :central
#   us8.add_role :nutricionista
#   us9.add_role :nutricionista

#   Area.create(:nombre => "Repostria" )
#   Area.create(:nombre => "Cocina Caliente" )
#   Area.create(:nombre =>  "Cocina Fria" )
#   Area.create(:nombre =>  "Dietas" )
#   Area.create(:nombre =>  "Lacteos" )
#   Area.create(:nombre =>  "Preliminares FV" )
#   Area.create(:nombre =>  "Preliminares CP" )

# puts 'dia regimen'

# DayRegime.create(:date => Date.today, :regime_day => 1)

p = Patient.last
r = Regime.last
puts "Agregando odenes"
20.times do |num|
  puts num
  25.times do
    a = OrderList.create(:patient_id => p.id, :esPaciente => true, :fecha => Date.today + num, :dia => 1)
    o = Order.create(:horario => 1, :comentarios => "asdfg", :regime_id => r.id, :estado => 1)
    o.plates << Plate.find(10 + rand(2000))
    o.plates << Plate.find(10 + rand(2000))
    o.plates << Plate.find(10 + rand(2000))
    o.plates << Plate.find(10 + rand(2000))
    a.orders << o
    o = Order.create(:horario => 2, :comentarios => "asdfg", :regime_id => r.id, :estado => 1)
    o.plates << Plate.find(10 + rand(2000))
    o.plates << Plate.find(10 + rand(2000))
    o.plates << Plate.find(10 + rand(2000))
    o.plates << Plate.find(10 + rand(2000))
    a.orders << o
    o = Order.create(:horario => 4, :comentarios => "asdfg", :regime_id => r.id, :estado => 1)
    o.plates << Plate.find(10 + rand(2000))
    o.plates << Plate.find(10 + rand(2000))
    o.plates << Plate.find(10 + rand(2000))
    o.plates << Plate.find(10 + rand(2000))
    a.orders << o
    o = Order.create(:horario => 8, :comentarios => "asdfg", :regime_id => r.id, :estado => 1)
    o.plates << Plate.find(10 + rand(2000))
    o.plates << Plate.find(10 + rand(2000))
    o.plates << Plate.find(10 + rand(2000))
    o.plates << Plate.find(10 + rand(2000))
    a.orders << o
  end
end

