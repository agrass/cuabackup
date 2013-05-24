class OrderList < ActiveRecord::Base
   attr_accessible :esPaciente, :patient_id, :orders_attributes

   has_many :orders
   belongs_to :patient
   accepts_nested_attributes_for :orders, :allow_destroy => true
end
