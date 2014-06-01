class PatientImportsController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource
	def new
		@patient_import = PatientImport.new
	end

	def create
		if params[:patient_import].nil?
			redirect_to new_patient_import_path , alert: "Debe seleccionar un archivo"
			return
		end
		@patient_import = PatientImport.new(params[:patient_import])
		if @patient_import.save
			redirect_to patients_path , notice: "Importacion realizada correctamente."
		else
			render :new
		end
	end
end