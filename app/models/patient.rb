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

	def self.import(file)
		self.set_piezas_to_nil
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			patient = find_by_rut(row["rut"]) || new
			patient.attributes = row.to_hash.slice(*accessible_attributes)
			patient.save!
		end
	end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
		when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
		when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
		when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
		else raise "Unknown file type: #{file.original_filename}"
		end
	end

	def self.set_piezas_to_nil
		Patient.all.each do |patient|
			patient.num_pieza = nil
			patient.save
		end
	end
end
