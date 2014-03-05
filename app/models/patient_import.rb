class PatientImport
  # switch to ActiveModel::Model in Rails 4
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_patients.map(&:valid?).all?
      imported_patients.each(&:save!)
      true
    else
      imported_patients.each_with_index do |patient, index|
        patient.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_patients
    @imported_patients ||= load_imported_patients
  end

  def load_imported_patients
    set_piezas_to_nil
    spreadsheet = open_spreadsheet
    patients = []
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      patient = Patient.find_by_rut(row["Rut"].hash.to_s)
      if patient.nil?
        patient = Patient.new
        patient.nombre = row["Paciente"].to_s
        patient.rut = row["Rut"].hash.to_s
      end
      patient.num_pieza = row["Cama"].to_s
      patients << patient
    end
    return patients
  end

  def set_piezas_to_nil
    Patient.all.each do |patient|
      patient.num_pieza = nil
      patient.save
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    when ".XLSX" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end