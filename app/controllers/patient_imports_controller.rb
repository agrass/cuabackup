class PatientImportsController < ApplicationController
	def new
		@patient_import = PatientImport.new
	end

	def create
		Patient.delete_all
		@patient_import = PatientImport.new(params[:patient_import])
		if @patient_import.save
			redirect_to patients_path , notice: "Importacion realizada correctamente."
		else
			render :new
		end
	end
end