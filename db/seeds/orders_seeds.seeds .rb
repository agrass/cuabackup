# p = Patient.last
# r = Regime.last
# puts "Agregando odenes"
# 20.times do |num|
# 	puts num
# 	25.times do
# 		a = OrderList.create(:patient_id => p.id, :esPaciente => true, :fecha => Date.today + num, :dia => 1)
# 		o = Order.create(:horario => 1, :comentarios => "asdfg", :regime_id => r.id, :estado => 1)
# 		o.plates << Plate.find(10 + rand(2000))
# 		o.plates << Plate.find(10 + rand(2000))
# 		o.plates << Plate.find(10 + rand(2000))
# 		o.plates << Plate.find(10 + rand(2000))
# 		a.orders << o
# 		o = Order.create(:horario => 2, :comentarios => "asdfg", :regime_id => r.id, :estado => 1)
# 		o.plates << Plate.find(10 + rand(2000))
# 		o.plates << Plate.find(10 + rand(2000))
# 		o.plates << Plate.find(10 + rand(2000))
# 		o.plates << Plate.find(10 + rand(2000))
# 		a.orders << o
# 		o = Order.create(:horario => 4, :comentarios => "asdfg", :regime_id => r.id, :estado => 1)
# 		o.plates << Plate.find(10 + rand(2000))
# 		o.plates << Plate.find(10 + rand(2000))
# 		o.plates << Plate.find(10 + rand(2000))
# 		o.plates << Plate.find(10 + rand(2000))
# 		a.orders << o
# 		o = Order.create(:horario => 8, :comentarios => "asdfg", :regime_id => r.id, :estado => 1)
# 		o.plates << Plate.find(10 + rand(2000))
# 		o.plates << Plate.find(10 + rand(2000))
# 		o.plates << Plate.find(10 + rand(2000))
# 		o.plates << Plate.find(10 + rand(2000))
# 		a.orders << o
# 	end
# end
