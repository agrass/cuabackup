class Patient < ActiveRecord::Base
  attr_accessible :nombre, :num_pieza, :rut
  has_many :order_lists

  def self.patients_group_by_num_pieza
      patient_info = Hash.new { |h, k| h[k] = [] }
      self.order('num_pieza ASC').each { |patient|
        patient_info[patient.id.to_s].push patient.nombre
      }
      patient_info
    end
end
